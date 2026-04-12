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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('設定 ${widget.memberName} 的個人化檔案')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('孩子年齡區間'),
          _buildAgeDropdown(),
          const SizedBox(height: 24),

          _buildSectionTitle('孩子性格'),
          _buildPersonalityChips(),
          const SizedBox(height: 24),

          _buildSectionTitle('家長教育導向 (您對他的教養方式)'),
          _buildParentStyleDropdown(),
          const SizedBox(height: 40),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              // TODO: 將設定好的選項存入 Provider 或後端
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('設定已儲存！')));
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
    return Wrap(
      spacing: 8.0,
      children: ChildPersonality.values.map((personality) {
        return ChoiceChip(
          label: Text(personality.label.split(' ')[0] + ' ' + personality.label.split(' ')[1]), // 只顯示 Icon 和名字
          selected: _selectedPersonality == personality,
          onSelected: (bool selected) {
            setState(() => _selectedPersonality = personality);
          },
        );
      }).toList(),
    );
  }
}