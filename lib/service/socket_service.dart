import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  SocketService._internal();

  IO.Socket? socket;
  bool isConnected = false;

  // Pending listeners until socket connects
  final List<Map<String, Function(dynamic)>> _pendingListeners = [];

  // Connect to socket
  void connect(String token) {
    if (isConnected || socket != null) {
      debugPrint('⚠️ Socket already connected');
      return;
    }

    debugPrint('🟡 Trying to connect socket...');
    socket = IO.io(
      'https://api.radeefz.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(20)
          .setReconnectionDelay(2000)
          .setReconnectionDelayMax(8000)
          .setAuth({"token": token})
          .build(),
    );

    socket!.connect();

    // Socket connected
    socket!.on('connect', (_) {
      isConnected = true;
      debugPrint('✅ SOCKET CONNECTED');
      debugPrint('🆔 Socket ID: ${socket!.id}');

      // Attach any pending listeners
      for (var listener in _pendingListeners) {
        listener.forEach((event, handler) {
          socket?.on(event, handler);
        });
      }
      _pendingListeners.clear();
    });

    socket!.on('disconnect', (_) {
      isConnected = false;
      debugPrint('❌ Socket Disconnected');
    });

    socket!.on('connect_error', (err) {
      isConnected = false;
      debugPrint('🔥 SOCKET CONNECT ERROR: $err');
    });
  }

  // Emit event
  void emit(String event, {dynamic data, Function(dynamic response)? ack}) {
    if (socket == null) return;

    if (ack != null) {
      socket!.emitWithAck(event, data, ack: ack);
      debugPrint(
        "============================ Emit event : $event ask : $ack ============================",
      );
    } else {
      socket!.emit(event, data);
    }
  }

  // Attach listener (will attach immediately if connected, or pending)
  void on(String event, Function(dynamic) handler) {
    if (isConnected) {
      socket?.on(event, handler);
    } else {
      _pendingListeners.add({event: handler});
    }
  }

  // Remove listener
  void off(String event) {
    socket?.off(event);
  }
}
