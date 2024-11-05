import 'package:flutter/material.dart';

class BackupScanning extends StatefulWidget {
  const BackupScanning({super.key});

  @override
  State<BackupScanning> createState() => _BackupScanningState();
}

class _BackupScanningState extends State<BackupScanning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup Scanning"),
        centerTitle: true,
      ),
    );
  }
}
