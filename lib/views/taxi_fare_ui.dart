
import 'package:flutter/material.dart';

class TaxiFareUI extends StatefulWidget {
  const TaxiFareUI({super.key});

  @override
  State<TaxiFareUI> createState() => _TaxiFareUIState();
}

class _TaxiFareUIState extends State<TaxiFareUI> {
  TextEditingController disctrl = TextEditingController();
  TextEditingController jamctrl = TextEditingController();

  String taxiFare = '0.00';
  String TFjam = '0.00';

  bool showWarning = false;

  @override
  void dispose() {
    disctrl.dispose();
    jamctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 250, 255),

      // แถบด้านบน
      appBar: AppBar(
        title: const Text(
          'Taxi Fare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 190, 0),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      // เนื้อหาหน้าคำนวณค่าโดยสาร
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 40,
              bottom: 30,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/taxi.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.contain,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),

                Text(
                  'คำนวณหาค่าโดยสารแท็กซี่',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ระยะทาง (กิโลเมตร) 🛣️',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: disctrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    hintText: 'กรุณากรอกระยะทาง',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'เวลารถติด (นาที) ⏰',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: jamctrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    hintText: 'กรุณากรอกเวลารถติด',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),

                // ปุ่มคำนวณค่าโดยสาร
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // ตรวจสอบว่ากรอกข้อมูลครบหรือไม่
                      if (disctrl.text.trim().isEmpty ||
                          jamctrl.text.trim().isEmpty) {
                        setState(() {
                          showWarning = true;
                        });
                        return;
                      }

                      double? dis =
                          double.tryParse(disctrl.text.trim());
                      double? jam =
                          double.tryParse(jamctrl.text.trim());

                      // ตรวจสอบข้อมูลที่กรอก
                      if (dis == null ||
                          jam == null ||
                          dis < 0 ||
                          jam < 0) {
                        setState(() {
                          showWarning = true;
                        });
                        return;
                      }

                      double jamfee = jam * 3;
                      double fare;

                      // คำนวณค่าโดยสารตามระยะทาง
                      if (dis <= 1) {
                        fare = 35;
                      } else if (dis <= 10) {
                        fare = 35 + (dis - 1) * 6.50;
                      } else if (dis <= 20) {
                        fare = 35 + 58.50 + (dis - 10) * 7.00;
                      } else if (dis <= 40) {
                        fare = 35 + 128.50 + (dis - 20) * 8.00;
                      } else if (dis <= 60) {
                        fare = 35 + 288.50 + (dis - 40) * 8.50;
                      } else if (dis <= 80) {
                        fare = 35 + 458.50 + (dis - 60) * 9.00;
                      } else {
                        fare = 35 + 638.50 + (dis - 80) * 10.50;
                      }

                      setState(() {
                        showWarning = false;
                        TFjam = jamfee.toStringAsFixed(2);
                        taxiFare =
                            (fare + jamfee).toStringAsFixed(2);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor:
                          const Color.fromARGB(255, 255, 190, 0),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'คำนวณค่าโดยสาร',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ปุ่มยกเลิก
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        disctrl.clear();
                        jamctrl.clear();
                        taxiFare = '0.00';
                        TFjam = '0.00';
                        showWarning = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                // กล่องแสดงค่าโดยสาร
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 245, 194),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'ค่าโดยสารแท็กซี่',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        taxiFare,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Color.fromARGB(255, 255, 65, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'บาท',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // แถบแจ้งเตือน แสดงเฉพาะเมื่อข้อมูลไม่ครบหรือไม่ถูกต้อง
      bottomNavigationBar: showWarning
          ? Container(
              color: const Color.fromARGB(255, 255, 65, 55),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: const SafeArea(
                top: false,
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.yellow,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'กรุณากรอกข้อมูลให้ครบถ้วนหรือถูกต้อง',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
