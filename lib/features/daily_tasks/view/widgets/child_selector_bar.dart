import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';

class ChildSelectorBar extends StatelessWidget {
  const ChildSelectorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    // 這裡的資料將來應該從 AuthProvider 或 FamilyService 拿，目前先模擬
    final childrenOptions = {"child_1": "小明", "child_2": "小華"};

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text("全部"),
            selected: provider.selectedChildId == null,
            onSelected: (_) => provider.selectChild(null),
          ),
          const SizedBox(width: 8),
          ...childrenOptions.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(entry.value),
              selected: provider.selectedChildId == entry.key,
              onSelected: (selected) => provider.selectChild(selected ? entry.key : null),
            ),
          )),
        ],
      ),
    );
  }
}