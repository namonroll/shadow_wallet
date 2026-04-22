import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanProductView extends StatefulWidget {
  const ScanProductView({super.key});

  @override
  State<ScanProductView> createState() => _ScanProductViewState();
}

class _ScanProductViewState extends State<ScanProductView> {
  bool _isScanned = false; // 防止重複掃描

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('掃描商品')),
      body: MobileScanner(
        onDetect: (capture) {
          if (_isScanned) return;
          
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            if (barcode.rawValue != null) {
              setState(() => _isScanned = true);
              _handleBarcode(barcode.rawValue!); // 處理掃到的內容
              break;
            }
          }
        },
      ),
    );
  }

  void _handleBarcode(String code) {
    // 這裡可以做兩件事：
    // 1. 比對 MockData 裡的商品列表
    // 2. 彈出確認購買視窗
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('掃描成功！條碼內容：$code', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('是否扣除 50 影子幣兌換此商品？'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: 呼叫 WalletProvider 扣款
                Navigator.pop(context); // 關閉 BottomSheet
                Navigator.pop(context); // 返回錢包頁面
              },
              child: const Text('確認兌換'),
            )
          ],
        ),
      ),
    ).then((_) => setState(() => _isScanned = false)); // 關閉視窗後恢復掃描
  }
}