import 'package:flutter/material.dart';
import 'package:binate_digital_reusable_widgets/extensions/string_extension.dart';

class OptionSelector<T> extends StatelessWidget {
  final List<T> options;
  final T? selectedOption;
  final Function(T)? onOptionSelected;
  const OptionSelector({
    super.key,
    required this.options,
    this.selectedOption,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colorScheme.primary,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children:
            options
                .map(
                  (option) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onOptionSelected?.call(option);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              option == selectedOption
                                  ? colorScheme.onPrimary
                                  : colorScheme.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          option is Enum
                              ? option.name.capitalize
                              : option.toString(),
                          textAlign: TextAlign.center,
                          style: textTheme.displayMedium!.copyWith(
                            fontSize: 14,
                            color:
                                option == selectedOption
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
