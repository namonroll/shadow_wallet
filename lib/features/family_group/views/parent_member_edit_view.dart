import 'package:flutter/material.dart';
import '../../../core/models/member_profile_enums.dart';

class ParentMemberEditView extends StatefulWidget {
  final String memberName; // 傳入要編輯的小孩名字
  const ParentMemberEditView({super.key, required this.memberName});

  @override
  State<ParentMemberEditView> createState() => _ParentMemberEditViewState();
}

class _ParentMemberEditViewState extends State<ParentMemberEditView> {
  // 預設選項
  ChildPersonality _selectedPersonality = ChildPersonality.dolphin;
  ParentStyle _selectedParentStyle = ParentStyle.coach;
  AgeGroup _selectedAgeGroup = AgeGroup.stage4;

  // 新增的理財參數 (先以變數儲存前端狀態)
  double _interestRate = 5.0; // 預設年利率 5%
  double _exchangeRate = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.memberName} 的個人化設定')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('孩子年齡區間'),
          _buildAgeDropdown(),
          const SizedBox(height: 24),

          _buildSectionTitle('孩子性格'),
          _buildPersonalityChips(),
          const SizedBox(height: 24),

          _buildSectionTitle('家長類型'),
          _buildParentStyleDropdown(),
          const SizedBox(height: 40),

          //利息設定區塊
          _buildSectionTitle('利息設定'),
          _buildInterestSlider(),
          const SizedBox(height: 24),

          //匯率設定區塊
          _buildSectionTitle('匯率設定'),
          _buildExchangeRateInput(),
          const SizedBox(height: 40),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              // TODO: 將 _interestRate 與 _exchangeRate 一併存入 Provider
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('設定已儲存')));
              Navigator.pop(context);
            },
            child: const Text('儲存設定', style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    );
  }
  Widget _buildInterestSlider() {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Slider(
              value: _interestRate,
              min: 0,
              max: 20, // 最高 20%
              divisions: 40, // 每 0.5 一格
              label: '${_interestRate.toStringAsFixed(1)}%',
              onChanged: (val) => setState(() => _interestRate = val),
            ),
          ],
        ),
      ),
    );
  }

  /// 使用輸入框或加減號設定匯率
  Widget _buildExchangeRateInput() {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.currency_exchange, color: Color.fromARGB(255, 255, 255, 255)),
                const SizedBox(width: 10),
                const Text('1 成長幣 = ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
            
                    },
                    controller: TextEditingController(text: _exchangeRate.toStringAsFixed(0)),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('台幣 (NTD)', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeDropdown() {
    return DropdownButtonFormField<AgeGroup>(
      value: _selectedAgeGroup,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: AgeGroup.values.map((age) => DropdownMenuItem(value: age, child: Text(age.label))).toList(),
      onChanged: (val) => setState(() => _selectedAgeGroup = val!),
    );
  }

  Widget _buildParentStyleDropdown() {
    return DropdownButtonFormField<ParentStyle>(
      value: _selectedParentStyle,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: ParentStyle.values.map((style) => DropdownMenuItem(value: style, child: Text(style.label))).toList(),
      onChanged: (val) => setState(() => _selectedParentStyle = val!),
    );
  }

  Widget _buildPersonalityChips() {
    return DropdownButtonFormField<ChildPersonality>(
      value: _selectedPersonality,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: ChildPersonality.values.map((style) => DropdownMenuItem(value: style, child: Text(style.label))).toList(),
      onChanged: (val) => setState(() => _selectedPersonality = val!),
    );
  }
}