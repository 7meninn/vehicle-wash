import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                title: Text(
                  'Profile',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(EnterpriseSpacing.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProfileHeader(theme),
                    const SizedBox(height: EnterpriseSpacing.sectionPadding / 2),
                    _buildSettingsGroup(
                      title: 'Account Settings',
                      theme: theme,
                      children: [
                        _buildSettingsTile(
                          icon: Icons.person_outline,
                          title: 'Personal Information',
                          theme: theme,
                          onTap: () {},
                        ),
                        _buildSettingsTile(
                          icon: Icons.payment_outlined,
                          title: 'Payment Methods',
                          theme: theme,
                          onTap: () {},
                        ),
                        _buildSettingsTile(
                          icon: Icons.location_on_outlined,
                          title: 'Saved Addresses',
                          theme: theme,
                          onTap: () => context.push('/addresses'),
                        ),
                        _buildSettingsTile(
                          icon: Icons.directions_car_outlined,
                          title: 'My Vehicles',
                          theme: theme,
                          onTap: () => context.push('/vehicles'),
                        ),
                      ],
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap * 2),
                    _buildSettingsGroup(
                      title: 'Preferences',
                      theme: theme,
                      children: [
                        _buildSettingsTile(
                          icon: Icons.notifications_none_outlined,
                          title: 'Notifications',
                          theme: theme,
                          onTap: () {},
                        ),
                        _buildSettingsTile(
                          icon: Icons.language_outlined,
                          title: 'Language',
                          trailing: Text('English', style: theme.textTheme.bodyMedium),
                          theme: theme,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: EnterpriseSpacing.gap * 3),
                    EnterpriseButton(
                      label: 'Log Out',
                      variant: EnterpriseButtonVariant.secondary,
                      onPressed: () {
                        // TODO: Implement logout
                        context.go('/login');
                      },
                    ),
                    const SizedBox(height: EnterpriseSpacing.sectionPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return EnterpriseCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            child: Icon(Icons.person, size: 36, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Doe', style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('+1 (555) 123-4567', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PREMIUM MEMBER',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: theme.colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup({
    required String title,
    required List<Widget> children,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: EnterpriseSpacing.gap),
        EnterpriseCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required ThemeData theme,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: theme.colorScheme.onSurface.withOpacity(0.7), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: theme.textTheme.titleMedium),
            ),
            if (trailing != null) trailing,
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }
}
