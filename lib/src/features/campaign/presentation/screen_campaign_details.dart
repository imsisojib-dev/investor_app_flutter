import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/core/theme/app_colors.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/core/helpers/widget_helper.dart';
import 'package:investor_app_flutter/src/shared/widgets/custom_card.dart';
import 'package:investor_app_flutter/src/shared/widgets/dotted_line.dart';

class ScreenCampaignDetails extends StatefulWidget {
  const ScreenCampaignDetails({super.key});

  @override
  State<ScreenCampaignDetails> createState() => _ScreenCampaignDetailsState();
}

class _ScreenCampaignDetailsState extends State<ScreenCampaignDetails> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showBottomBar = true;
  int _investAmount = 50500;
  bool _breakdownExpanded = true;

  late AnimationController _bottomBarController;
  late Animation<double> _bottomBarAnimation;

  @override
  void initState() {
    super.initState();

    _bottomBarController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _bottomBarAnimation = CurvedAnimation(parent: _bottomBarController, curve: Curves.easeOutCubic);

    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 120;
      if (shouldShow != _showBottomBar) {
        setState(() => _showBottomBar = shouldShow);
        if (shouldShow) {
          _bottomBarController.forward();
        } else {
          _bottomBarController.reverse();
        }
      }
    });

    //initially show bottom bar controls
    _bottomBarController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bottomBarController.dispose();
    super.dispose();
  }

  double get _estimatedRepayment => _investAmount * 1.108;

  double get _estimatedProfit => _investAmount * 0.108;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildCompanyHeader(),
                    const SizedBox(height: 12),
                    _buildStatsRow(),
                    const SizedBox(height: 12),
                    _buildFundingProgress(),
                    const SizedBox(height: 12),
                    _buildInvestmentSummaryCard(),
                    const SizedBox(height: 12),
                    _buildBreakdownCard(),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 240)),
            ],
          ),

          /// Animated bottom control panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bottomBarAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _bottomBarAnimation.value) * 100),
                  child: Opacity(opacity: _bottomBarAnimation.value, child: child),
                );
              },
              child: _buildInvestControls(),
            ),
          ),
        ],
      ),
    );
  }

  /// Sliver AppBar
  Widget _buildSliverAppBar() {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      title: Text('Shamolima Limited', style: theme.textTheme.titleLarge),
      centerTitle: false,
      actions: [IconButton(icon: const Icon(Icons.more_vert_rounded, size: 22), onPressed: () {})],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/pngs/dummy_transport_company.png', height: 160.h, width: double.infinity, fit: BoxFit.cover),
          ).padding(const EdgeInsets.symmetric(horizontal: 16)),
        ),
      ),
    );
  }

  /// Company header
  Widget _buildCompanyHeader() {
    final theme = Theme.of(context);

    return CustomCard(
      backgroundColor: Color(0xffFEFAEB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.appColors.borderColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/pngs/dummy_company_logo.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('15% annualized', style: theme.textTheme.titleLarge?.copyWith(fontSize: 18)),
                ],
              ),
              Text('Risk Grade: A+', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Transport & Logistics', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
          const SizedBox(height: 2),
          Text('Serving 100+ industry renowned corporate clients', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  /// Invest Highlight Row
  Widget _buildStatsRow() {
    return CustomCard(
      backgroundColor: Color(0xffF0FAFD),
      child: Row(
        children: [
          _StatItem(label: 'Profit', value: '15%', highlight: true),
          _Divider(),
          _StatItem(label: 'Tenure', value: 'Annualized'),
          _Divider(),
          _StatItem(label: 'Duration', value: '7 months'),
          _Divider(),
          _StatItem(label: 'Time left', value: '4 days'),
        ],
      ),
    );
  }

  /// Funding Progress
  Widget _buildFundingProgress() {
    final theme = Theme.of(context);

    const raised = 2109856.0;
    const target = 4000000.0;
    const progress = raised / target;

    return CustomCard(
      backgroundColor: Color(0xffF9F9F9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '52.75% Raised ', style: theme.textTheme.bodySmall),
                    TextSpan(text: '(21,09,856)', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Text('40,00,000', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: theme.appColors.secondaryWithOpacity,
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: theme.colorScheme.dividerColor,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: theme.appColors.secondaryWithOpacity),
                ),
              ),
              const SizedBox(width: 6),
              Text('Processing Investment of 16,57,488', style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  /// Invest Summary Card
  Widget _buildInvestmentSummaryCard() {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xffFAFFFE),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xffDCEDEC), width: 1),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Investing', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Text(WidgetHelper.formatAmount(_investAmount.toDouble()), style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(color: Color(0xffDCEDEC), thickness: 2, width: 1),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Estimated Repayment', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 4),
                        Text('Up to ${WidgetHelper.formatAmount(_estimatedRepayment)}', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          '+${WidgetHelper.formatAmount(_estimatedProfit)} (10.80%)',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('* ', style: TextStyle(fontSize: 12)),
              Expanded(child: Text('Estimated maximum ROI. Please check contract details for additional details', style: theme.textTheme.bodySmall)),
            ],
          ),
        ),
      ],
    );
  }

  /// breakdown card
  Widget _buildBreakdownCard() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.appColors.borderColor),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _breakdownExpanded = !_breakdownExpanded),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated Repayment Breakdown', style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18)),
                AnimatedRotation(
                  turns: _breakdownExpanded ? 0 : 0.5,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(Icons.keyboard_arrow_up_rounded, size: 24),
                ),
              ],
            ).padding(EdgeInsets.only(left: 16, right: 16, top: 16)),
          ),
          AnimatedCrossFade(
            firstChild: _buildBreakdownRows(),
            secondChild: const SizedBox(width: double.infinity, height: 16),
            crossFadeState: _breakdownExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRows() {
    final rows = [
      _BreakdownRow('Investment', WidgetHelper.formatAmount(_investAmount.toDouble())),
      _BreakdownRow('Estimated Profit', '${WidgetHelper.formatAmount(_investAmount * 0.0854)} – ${WidgetHelper.formatAmount(_investAmount * 0.109)}', subtitle: null),
      _BreakdownRow(
        'Success Fee',
        '${WidgetHelper.formatAmount(_investAmount * 0.00085)} – ${WidgetHelper.formatAmount(_investAmount * 0.001)}',
        subtitle: '0.08 – 0.1% of repayment',
      ),
      _BreakdownRow('Discount (100%)', WidgetHelper.formatAmount(_investAmount.toDouble()), subtitle: 'Applicable to success fee'),
      _BreakdownRow('Charges on Investment (0.1%)', WidgetHelper.formatAmount(_investAmount.toDouble())),
      _BreakdownRow('Net Charges', WidgetHelper.formatAmount(_investAmount.toDouble()), isBold: true),
      _BreakdownRow(
        'Net Estimated Profit',
        '${WidgetHelper.formatAmount(_investAmount * 0.0844)} – ${WidgetHelper.formatAmount(_investAmount * 0.108)}',
        subtitle: '14.65 – 18.69% annualized',
        isGreen: true,
      ),
      _BreakdownRow(
        'Estimated Repayment',
        '${WidgetHelper.formatAmount(_investAmount * 1.0844)} – ${WidgetHelper.formatAmount(_investAmount * 1.108)}',
        isBold: true,
        isGreen: true,
      ),
    ];

    return Column(children: [const SizedBox(height: 16), ...rows.map((r) => _buildRow(r)).toList()]);
  }

  Widget _buildRow(_BreakdownRow row) {
    final theme = Theme.of(context);

    return Column(
      children: [
        DottedLine(color: theme.appColors.borderColor, dotSize: 2, spacing: 4),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      row.label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: row.isBold ? FontWeight.w700 : FontWeight.w400,
                        color: row.isBold ? null : theme.appColors.textSecondary,
                      ),
                    ),
                    if (row.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        row.subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: row.isBold ? FontWeight.w700 : FontWeight.w400,
                          color: row.isBold ? null : theme.appColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Text(row.value, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13, fontWeight: row.isBold ? FontWeight.w700 : FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  /// Floating invest controls
  Widget _buildInvestControls() {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        boxShadow: [BoxShadow(offset: Offset(0, -3), blurRadius: 15, spreadRadius: 0, color: Color(0x51677733))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('I want to invest', style: theme.textTheme.bodyMedium?.copyWith(color: theme.appColors.textSecondary)),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.primaryColor),
            ),
            child: Row(
              children: [
                _AmountButton(
                  label: '– 5K',
                  onTap: () => setState(() {
                    if (_investAmount > 5000) _investAmount -= 5000;
                  }),
                ),
                Expanded(
                  child: Center(
                    child: Text(WidgetHelper.formatAmount(_investAmount.toDouble()), style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)),
                  ),
                ),
                _AmountButton(label: '+ 5K', onTap: () => setState(() => _investAmount += 5000), isRight: true),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                //backgroundColor: _C.green,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.2)),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final Color? valueColor;

  const _StatItem({required this.label, required this.value, this.highlight = false, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.textSecondary)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 32);
  }
}

class _AmountButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isRight;

  const _AmountButton({required this.label, required this.onTap, this.isRight = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 48.h,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.horizontal(
            left: isRight ? Radius.zero : const Radius.circular(13),
            right: isRight ? const Radius.circular(13) : Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// dummy data model
class _BreakdownRow {
  final String label;
  final String value;
  final String? subtitle;
  final bool isBold;
  final bool isGreen;

  const _BreakdownRow(this.label, this.value, {this.subtitle, this.isBold = false, this.isGreen = false});
}
