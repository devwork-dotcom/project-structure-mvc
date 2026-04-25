import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_structure/core/utils/constants/app_sizer.dart';

import '../../utils/constants/app_colors.dart';

class CustomHtmlText extends StatelessWidget {
  final String text;

  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  final int? maxLines;
  final TextOverflow? textOverflow;
  final double? maxHeight;
  final bool compact;

  const CustomHtmlText({
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.textOverflow,
    this.maxHeight,
    this.compact = true,
  });

  @override
  Widget build(BuildContext context) {
    final baseSize = fontSize ?? 14.sp;
    final baseColor = color ?? AppColors.textPrimary;
    final baseWeight = fontWeight ?? FontWeight.w400;

    Widget htmlWidget = Html(
      data: text,
      style: {
        /// ================= BODY =================
        "body": Style(
          margin: compact ? Margins.zero : null,
          padding: compact ? HtmlPaddings.zero : null,
          fontSize: FontSize(baseSize),
          fontWeight: baseWeight,
          color: baseColor,
          fontFamily: GoogleFonts.inter().fontFamily,
          textAlign: textAlign,
          lineHeight: const LineHeight(1.4),
          maxLines: maxLines,
          textOverflow: textOverflow,
        ),

        /// ================= HEADINGS =================
        "h1": Style(
          fontSize: FontSize(baseSize + 8),
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          margin: compact ? Margins.only(bottom: 8) : null,
        ),
        "h2": Style(
          fontSize: FontSize(baseSize + 6),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        "h3": Style(
          fontSize: FontSize(baseSize + 4),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        "h4": Style(
          fontSize: FontSize(baseSize + 2),
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),

        /// ================= PARAGRAPH =================
        "p": Style(
          margin: compact ? Margins.only(bottom: 6) : null,
          padding: HtmlPaddings.zero,
        ),

        /// ================= STRONG / BOLD =================
        "strong": Style(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        "b": Style(fontWeight: FontWeight.w600),

        /// ================= ITALIC =================
        "i": Style(fontStyle: FontStyle.italic),
        "em": Style(fontStyle: FontStyle.italic),

        /// ================= LINKS =================
        "a": Style(
          color: AppColors.primary,
          textDecoration: TextDecoration.underline,
        ),

        /// ================= LIST =================
        "ul": Style(
          margin: compact ? Margins.only(left: 12, bottom: 6) : null,
          padding: HtmlPaddings.zero,
        ),
        "ol": Style(
          margin: compact ? Margins.only(left: 12, bottom: 6) : null,
          padding: HtmlPaddings.zero,
        ),
        "li": Style(
          fontSize: FontSize(baseSize),
          color: baseColor,
          margin: compact ? Margins.only(bottom: 4) : null,
        ),

        /// ================= BLOCKQUOTE =================
        "blockquote": Style(
          backgroundColor: AppColors.textSecondary,
          padding: HtmlPaddings.all(8),
          margin: compact ? Margins.only(bottom: 8) : null,
          border: Border(left: BorderSide(color: AppColors.primary, width: 3)),
          fontStyle: FontStyle.italic,
        ),

        /// ================= CODE =================
        "code": Style(
          backgroundColor: AppColors.containerSoft,
          padding: HtmlPaddings.symmetric(horizontal: 6, vertical: 4),
          fontFamily: 'monospace',
          fontSize: FontSize(baseSize - 1),
        ),

        /// ================= TABLE =================
        "table": Style(backgroundColor: AppColors.white.withAlpha(0)),
        "th": Style(
          backgroundColor: AppColors.textSecondary,
          padding: HtmlPaddings.all(6),
          fontWeight: FontWeight.w600,
        ),
        "td": Style(padding: HtmlPaddings.all(6)),

        /// ================= IMAGE =================
        "img": Style(margin: Margins.only(top: 8, bottom: 8)),

        /// ================= SPAN (color support) =================
        /// IMPORTANT: don't override color here
        /// so inline style="color:red" works
        "span": Style(fontSize: FontSize(baseSize)),
      },

      /// Enable inline style color support
      extensions: [
        TagExtension(
          tagsToExtend: {"span"},
          builder: (context) {
            return Text(
              context.element?.text ?? "",
              style: TextStyle(color: context.style?.color, fontSize: baseSize),
            );
          },
        ),
      ],
    );

    if (maxHeight != null) {
      return SizedBox(height: maxHeight, child: htmlWidget);
    }

    return htmlWidget;
  }
}
