import 'package:flutter/material.dart';
import 'package:investor_app_flutter/src/config/extensions/widget_extensions.dart';
import 'package:investor_app_flutter/src/config/routes/routes.dart';
import 'package:investor_app_flutter/src/core/enums/e_bottomnavigation.dart';
import 'package:investor_app_flutter/src/core/helpers/widget_helper.dart';
import 'package:investor_app_flutter/src/core/theme/app_theme_extension.dart';
import 'package:investor_app_flutter/src/shared/widgets/app_bottomnavigationbar.dart';
import 'package:investor_app_flutter/src/shared/widgets/custom_card.dart';
import 'package:investor_app_flutter/src/shared/widgets/dotted_line.dart';

class ScreenPortfolio extends StatefulWidget {
  const ScreenPortfolio({super.key});

  @override
  State<ScreenPortfolio> createState() => _ScreenPortfolioState();
}

class _ScreenPortfolioState extends State<ScreenPortfolio> {
  bool _paymentsExpanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.appColors.scaffoldSecondaryBg,
      appBar: AppBar(title: const Text('Portfolio'), centerTitle: false, automaticallyImplyLeading: false),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildSummaryCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildStatsRow()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildNextPaymentCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Text(
              'Active Investments',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.appColors.textSecondary),
            ).padding(const EdgeInsets.symmetric(horizontal: 20)),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: _buildActiveCampaign(
              companyName: 'Shamolima Limited',
              sector: 'Transport & Logistics',
              invested: 50500,
              roi: 10.8,
              dueDate: 'Aug 2025',
              status: 'Active',
              onTap: () {
                Navigator.pushNamed(context, Routes.campaignDetailsScreen);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: _buildActiveCampaign(
              companyName: 'GreenHarvest Agro',
              sector: 'Agriculture',
              invested: 25000,
              roi: 12.5,
              dueDate: 'Sep 2025',
              status: 'Active',
              onTap: () {
                Navigator.pushNamed(context, Routes.campaignDetailsScreen);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: _buildActiveCampaign(
              companyName: 'MediCore Health',
              sector: 'Healthcare',
              invested: 75000,
              roi: 9.5,
              dueDate: 'Jul 2025',
              status: 'Maturing',
              statusColor: const Color(0xFFFFA726),
              onTap: () {
                Navigator.pushNamed(context, Routes.campaignDetailsScreen);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildPaymentScheduleCard()),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigationBar(state: EBottomNavigationBar.portfolio),
    );
  }

  Widget _buildSummaryCard() {
    final theme = Theme.of(context);

    const totalInvested = 150500.0;
    const projectedReturn = 166754.0;
    const roi = 10.8;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Invested', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.75))),
          const SizedBox(height: 4),
          Text(
            '৳ ${WidgetHelper.formatAmount(totalInvested)}',
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Projected Return', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.7))),
                    const SizedBox(height: 4),
                    Text(
                      '৳ ${WidgetHelper.formatAmount(projectedReturn)}',
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 36, color: Colors.white.withValues(alpha: 0.3)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Overall ROI', style: theme.textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.7))),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.trending_up_rounded, color: Color(0xFF88EFC9), size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '+$roi%',
                          style: theme.textTheme.bodyLarge?.copyWith(color: const Color(0xFF88EFC9), fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final theme = Theme.of(context);

    return CustomCard(
      backgroundColor: const Color(0xffF0FAFD),
      child: Row(
        children: [
          _StatItem(label: 'Campaigns', value: '3'),
          Container(width: 1, height: 32, color: theme.appColors.borderColor),
          _StatItem(label: 'Avg ROI', value: '10.9%', highlight: true),
          Container(width: 1, height: 32, color: theme.appColors.borderColor),
          _StatItem(label: 'Net Profit', value: '৳ 16,254'),
          Container(width: 1, height: 32, color: theme.appColors.borderColor),
          _StatItem(label: 'Maturing', value: '1'),
        ],
      ),
    );
  }

  Widget _buildNextPaymentCard() {
    final theme = Theme.of(context);

    return CustomCard(
      backgroundColor: const Color(0xffFEFAEB),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next Payment', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                const SizedBox(height: 2),
                Text('15 Jul 2025', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Expected', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
              const SizedBox(height: 2),
              Text(
                '৳ ${WidgetHelper.formatAmount(8312)}',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.secondary, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCampaign({
    required String companyName,
    required String sector,
    required double invested,
    required double roi,
    required String dueDate,
    required String status,
    Color? statusColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    final projectedReturn = invested * (1 + roi / 100);
    final profit = projectedReturn - invested;
    final effectiveStatusColor = statusColor ?? theme.appColors.success;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.appColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.appColors.borderColor),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffFEFAEB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: theme.appColors.borderColor),
                        ),
                        child: Center(
                          child: Text(companyName[0], style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(companyName, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                            Text(sector, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: effectiveStatusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          status,
                          style: theme.textTheme.bodySmall?.copyWith(color: effectiveStatusColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InvestStat(label: 'Invested', value: '৳ ${WidgetHelper.formatAmount(invested)}'),
                      _InvestStat(label: 'Proj. Return', value: '৳ ${WidgetHelper.formatAmount(projectedReturn)}'),
                      _InvestStat(label: 'ROI', value: '+$roi%', valueColor: theme.appColors.success),
                      _InvestStat(label: 'Due', value: dueDate),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: 0.65,
                      minHeight: 6,
                      backgroundColor: theme.appColors.secondaryWithOpacity,
                      valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Campaign progress', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                      Text('65%', style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            DottedLine(color: theme.appColors.borderColor, dotSize: 2, spacing: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, size: 14, color: theme.appColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        'Profit: +৳ ${WidgetHelper.formatAmount(profit)}',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.success, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'View Details',
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 10, color: theme.colorScheme.primary),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentScheduleCard() {
    final theme = Theme.of(context);

    final payments = [
      _PaymentRow('Shamolima Limited', '15 Jul 2025', 5445, isPaid: false),
      _PaymentRow('GreenHarvest Agro', '22 Jul 2025', 3125, isPaid: false),
      _PaymentRow('MediCore Health', '01 Jun 2025', 7125, isPaid: true),
      _PaymentRow('Shamolima Limited', '15 May 2025', 5445, isPaid: true),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.appColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.appColors.borderColor),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => setState(() => _paymentsExpanded = !_paymentsExpanded),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Schedule', style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18)),
                AnimatedRotation(
                  turns: _paymentsExpanded ? 0 : 0.5,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(Icons.keyboard_arrow_up_rounded, size: 24),
                ),
              ],
            ).padding(const EdgeInsets.only(left: 16, right: 16, top: 16)),
          ),
          AnimatedCrossFade(
            firstChild: Column(children: [const SizedBox(height: 12), ...payments.map((p) => _buildPaymentRow(p)), const SizedBox(height: 4)]),
            secondChild: const SizedBox(width: double.infinity, height: 16),
            crossFadeState: _paymentsExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(_PaymentRow row) {
    final theme = Theme.of(context);

    return Column(
      children: [
        DottedLine(color: theme.appColors.borderColor, dotSize: 2, spacing: 4),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: row.isPaid ? theme.appColors.success.withValues(alpha: 0.1) : theme.appColors.warning.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  row.isPaid ? Icons.check_rounded : Icons.schedule_rounded,
                  size: 16,
                  color: row.isPaid ? theme.appColors.success : theme.appColors.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(row.companyName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(row.date, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '৳ ${WidgetHelper.formatAmount(row.amount.toDouble())}',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: row.isPaid ? theme.appColors.success.withValues(alpha: 0.1) : theme.appColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      row.isPaid ? 'Paid' : 'Upcoming',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: row.isPaid ? theme.appColors.success : theme.appColors.warning,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _StatItem({required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary)),
          const SizedBox(height: 4),
          Text(
            value,
            style: highlight ? theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.secondary, fontWeight: FontWeight.w700) : null,
          ),
        ],
      ),
    );
  }
}

class _InvestStat extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InvestStat({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.appColors.textSecondary, fontSize: 10)),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class _PaymentRow {
  final String companyName;
  final String date;
  final int amount;
  final bool isPaid;

  const _PaymentRow(this.companyName, this.date, this.amount, {required this.isPaid});
}
