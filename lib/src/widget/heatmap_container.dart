import 'package:flutter/material.dart';
import '../data/heatmap_color.dart';

class HeatMapContainer extends StatelessWidget {
  final DateTime date;
  final double? size;
  final double? fontSize;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? textColor;
  final Color? currentDayColor;
  final EdgeInsets? margin;
  final bool? showText;
  final bool? isOutOfMonth;
  final Function(DateTime dateTime)? onClick;

  const HeatMapContainer({
    Key? key,
    required this.date,
    this.margin,
    this.size,
    this.fontSize,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.onClick,
    this.showText,
    this.currentDayColor,
    this.isOutOfMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Si le jour est hors du mois, utiliser une couleur gris clair
    Color finalTextColor = (isOutOfMonth ?? false)
        ? const Color(0xFFD0D0D0)
        : (textColor ?? const Color(0xFF8A8A8A));

    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedColor,
              border: DateTime(now.year, now.month, now.day).isAtSameMomentAs(
                      DateTime(date.year, date.month, date.day))
                  ? Border.all(
                      color: currentDayColor ?? HeatMapColor.defaultColor)
                  : null,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
            child: (showText ?? true)
                ? Text(
                    date.day.toString(),
                    style: TextStyle(color: finalTextColor, fontSize: fontSize),
                  )
                : null,
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }
}
