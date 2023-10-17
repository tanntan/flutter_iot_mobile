import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';
import 'package:esp_provisioning/esp_provisioning.dart';
import 'package:permission_handler/permission_handler.dart';

class BleService {
  static BleService? _instance;
  // static BleManager _bleManager;
  static Logger log = Logger(printer: PrettyPrinter());
  bool _isPowerOn = false;
  StreamSubscription<BluetoothAdapterState>? _stateSubscription;
  BluetoothDevice? selectedBluetoothDevice;

  static BleService getInstance() {
    _instance ??= BleService();
    log.v('BleService started');
    return _instance!;
  }

  Future<BluetoothAdapterState> start() async {
    log.i('Ble sevice start');
    if (_isPowerOn) {
      var state = await _waitForBluetoothPoweredOn();
      log.i('Device power was on $state');
      return state;
    }
    var isPermissionOk = await requestBlePermissions();
    if (!isPermissionOk) {
      throw Future.error(Exception('Location permission not granted'));
    }

    log.v('createClient');

    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      // restoreStateIdentifier: "example-ble-client-id",
      for (var result in results) {
        BluetoothDevice bluetoothDevice = result.device;
        // ignore: deprecated_member_use
        log.v("Restored bluetoothDevice: ${bluetoothDevice.name}");
        selectedBluetoothDevice = bluetoothDevice;
      }
    });

    var state = await _waitForBluetoothPoweredOn();
    _isPowerOn = true;
    return state;
  }

  void select(BluetoothDevice bluetoothDevice) {
    selectedBluetoothDevice = bluetoothDevice;
    log.v('selectedPeripheral = $selectedBluetoothDevice');
  }

  Future<bool> stop() async {
    if (!_isPowerOn) {
      return true;
    }
    _isPowerOn = false;
    stopScanBle();

    await _stateSubscription?.cancel();
    BluetoothConnectionState? deviceState =
        (await selectedBluetoothDevice?.connectionState.first);
    bool check = deviceState == BluetoothConnectionState.connected;
    if (check) {
      selectedBluetoothDevice?.disconnect();
    }

    return true;
  }

  Stream<List<ScanResult>> scanBle(List<Guid> services) {
    stopScanBle();
    FlutterBluePlus.startScan(
        withServices: services,
        timeout: const Duration(seconds: 4),
        androidUsesFineLocation: true);
    return FlutterBluePlus.scanResults;
    // return _bleManager.startPeripheralScan(
    //     uuids: [TransportBLE.PROV_BLE_SERVICE],
    //     scanMode: ScanMode.balanced,
    //     allowDuplicates: true);
  }

  Future<void> stopScanBle() {
    return FlutterBluePlus.stopScan();
  }

  Future<EspProv> startProvisioning(
      {BluetoothDevice? bluetoothDevice, String pop = 'abcd1234'}) async {
    if (!_isPowerOn) {
      await _waitForBluetoothPoweredOn();
    }
    BluetoothDevice p = bluetoothDevice ?? selectedBluetoothDevice!;
    log.v('peripheral $p');
    await stopScanBle();
    EspProv prov =
        EspProv(transport: TransportBLE(p), security: Security1(pop: pop));
    await prov.establishSession();
    // var success = await prov.establishSession();
    // if (!success) {
    //   throw Exception('Error establishSession');
    // }
    return prov;
  }

  Future<BluetoothAdapterState> _waitForBluetoothPoweredOn() async {
    Completer completer = Completer<BluetoothAdapterState>();

    _stateSubscription?.cancel();
    _stateSubscription = FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState bluetoothState) {
      if ((bluetoothState == BluetoothAdapterState.on ||
              bluetoothState == BluetoothAdapterState.unauthorized) &&
          !completer.isCompleted) {
        completer.complete(bluetoothState);
      }
    });

    return completer.future.timeout(const Duration(seconds: 5),
            onTimeout: () =>
                throw Exception('Wait for Bluetooth PowerOn timeout'))
        as Future<BluetoothAdapterState>;
  }

  Future<bool> requestBlePermissions() async {
    var isLocationGranted = await Permission.locationWhenInUse.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothAdvertise.request();
    log.v('checkBlePermissions, isLocationGranted=$isLocationGranted');
    return isLocationGranted == PermissionStatus.granted;
  }
}
