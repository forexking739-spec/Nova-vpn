
import 'package:flutter/material.dart';

void main() => runApp(const NovaApp());

const bg = Color(0xFF060916);
const blue = Color(0xFF398BFF);
const purple = Color(0xFF914DFF);
const card = Color(0xFF111A30);

class Server {
  final String country, flag, city;
  final bool premium;

  const Server(this.country, this.flag, this.city,
      {this.premium = false});
}

const servers = [
  Server('United States', '🇺🇸', 'New York'),
  Server('United States', '🇺🇸', 'Los Angeles', premium: true),
  Server('United States', '🇺🇸', 'Chicago', premium: true),
  Server('United States', '🇺🇸', 'Dallas', premium: true),
  Server('Canada', '🇨🇦', 'Toronto'),
  Server('Canada', '🇨🇦', 'Vancouver', premium: true),
  Server('United Kingdom', '🇬🇧', 'London'),
  Server('United Kingdom', '🇬🇧', 'Manchester', premium: true),
  Server('Germany', '🇩🇪', 'Frankfurt'),
  Server('Germany', '🇩🇪', 'Berlin', premium: true),
  Server('France', '🇫🇷', 'Paris', premium: true),
  Server('Netherlands', '🇳🇱', 'Amsterdam', premium: true),
  Server('Switzerland', '🇨🇭', 'Zurich', premium: true),
  Server('Sweden', '🇸🇪', 'Stockholm', premium: true),
  Server('Norway', '🇳🇴', 'Oslo', premium: true),
  Server('Italy', '🇮🇹', 'Milan', premium: true),
  Server('Spain', '🇪🇸', 'Madrid', premium: true),
  Server('Turkey', '🇹🇷', 'Istanbul', premium: true),
  Server('Poland', '🇵🇱', 'Warsaw', premium: true),
  Server('Singapore', '🇸🇬', 'Singapore'),
  Server('Japan', '🇯🇵', 'Tokyo', premium: true),
  Server('Japan', '🇯🇵', 'Osaka', premium: true),
  Server('South Korea', '🇰🇷', 'Seoul', premium: true),
  Server('India', '🇮🇳', 'Mumbai'),
  Server('India', '🇮🇳', 'Delhi', premium: true),
  Server('Malaysia', '🇲🇾', 'Kuala Lumpur', premium: true),
  Server('Indonesia', '🇮🇩', 'Jakarta', premium: true),
  Server('Thailand', '🇹🇭', 'Bangkok', premium: true),
  Server('UAE', '🇦🇪', 'Dubai', premium: true),
  Server('Saudi Arabia', '🇸🇦', 'Riyadh', premium: true),
  Server('Pakistan', '🇵🇰', 'Karachi'),
  Server('Pakistan', '🇵🇰', 'Lahore', premium: true),
  Server('Australia', '🇦🇺', 'Sydney', premium: true),
  Server('Australia', '🇦🇺', 'Melbourne', premium: true),
  Server('New Zealand', '🇳🇿', 'Auckland', premium: true),
  Server('Brazil', '🇧🇷', 'Sao Paulo', premium: true),
  Server('Argentina', '🇦🇷', 'Buenos Aires', premium: true),
  Server('Chile', '🇨🇱', 'Santiago', premium: true),
  Server('South Africa', '🇿🇦', 'Johannesburg', premium: true),
  Server('Egypt', '🇪🇬', 'Cairo', premium: true),
];

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOVA VPN',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: blue,
          secondary: purple,
        ),
      ),
      home: const NovaHome(),
    );
  }
}

class NovaHome extends StatefulWidget {
  const NovaHome({super.key});

  @override
  State<NovaHome> createState() => _NovaHomeState();
}

class _NovaHomeState extends State<NovaHome>
    with SingleTickerProviderStateMixin {
  late AnimationController pulse;

  Server selected = servers[8];

  bool premiumUser = false;
  bool autoConnect = false;
  bool killSwitch = false;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    pulse.dispose();
    super.dispose();
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: card,
      ),
    );
  }

  void showServers() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF101A32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        String search = '';
        String filter = 'All';

        return StatefulBuilder(
          builder: (context, setSheetState) {
            final filtered = servers.where((s) {
              final matchesSearch =
                  s.country.toLowerCase().contains(search.toLowerCase()) ||
                  s.city.toLowerCase().contains(search.toLowerCase());

              final matchesFilter = filter == 'All' ||
                  (filter == 'Free' && !s.premium) ||
                  (filter == 'Premium' && s.premium);

              return matchesSearch && matchesFilter;
            }).toList();

            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .82,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        width: 42,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Choose your location',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextField(
                        onChanged: (v) =>
                            setSheetState(() => search = v),
                        decoration: InputDecoration(
                          hintText: 'Search country or city',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white.withOpacity(.06),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: ['All', 'Free', 'Premium'].map((f) {
                          final active = filter == f;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: ChoiceChip(
                                label: Center(child: Text(f)),
                                selected: active,
                                onSelected: (_) =>
                                    setSheetState(() => filter = f),
                                selectedColor: blue,
                                backgroundColor: card,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: filtered.isEmpty
                            ? const Center(
                                child: Text('No locations found'),
                              )
                            : ListView.builder(
                                itemCount: filtered.length,
                                itemBuilder: (context, index) {
                                  final s = filtered[index];
                                  final isSelected =
                                      selected.city == s.city &&
                                      selected.country == s.country;

                                  return ListTile(
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    leading: Text(
                                      s.flag,
                                      style: const TextStyle(fontSize: 29),
                                    ),
                                    title: Text(
                                      s.country,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(s.city),
                                    trailing: s.premium
                                        ? const Icon(
                                            Icons.lock,
                                            color: purple,
                                            size: 19,
                                          )
                                        : Icon(
                                            isSelected
                                                ? Icons.check_circle
                                                : Icons.chevron_right,
                                            color: blue,
                                          ),
                                    onTap: () {
                                      if (s.premium && !premiumUser) {
                                        Navigator.pop(context);
                                        showPremium();
                                        return;
                                      }

                                      setState(() => selected = s);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showPremium() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: card,
        title: const Text('NOVA PREMIUM'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$5 / month',
              style: TextStyle(
                fontSize: 28,
                color: blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text('• Access to Premium locations'),
            Text('• More city choices'),
            Text('• Premium server selection'),
            SizedBox(height: 12),
            Text(
              'Payment is not connected yet.',
              style: TextStyle(color: Colors.orangeAccent),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              message('Subscription payment setup is required.');
            },
            child: const Text('SUBSCRIBE'),
          ),
        ],
      ),
    );
  }

  void showSettings() {
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: card,
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Auto connect'),
                  value: autoConnect,
                  onChanged: (v) {
                    setState(() => autoConnect = v);
                    setDialogState(() {});
                  },
                ),
                SwitchListTile(
                  title: const Text('Kill switch'),
                  value: killSwitch,
                  onChanged: (v) {
                    setState(() => killSwitch = v);
                    setDialogState(() {});
                  },
                ),
                SwitchListTile(
                  title: const Text('Notifications'),
                  value: notifications,
                  onChanged: (v) {
                    setState(() => notifications = v);
                    setDialogState(() {});
                  },
                ),
                const Divider(),
                const ListTile(
                  title: Text('Protocol'),
                  subtitle: Text('WireGuard integration required'),
                ),
                const ListTile(
                  title: Text('App version'),
                  subtitle: Text('NOVA VPN 1.0.0'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('DONE'),
              ),
            ],
          );
        },
      ),
    );
  }

  void connect() {
    message(
      'VPN is not connected. A real WireGuard server and configuration are required.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF101C3C),
              bg,
              Color(0xFF180E32),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [blue, purple],
                        ),
                      ),
                      child: const Icon(
                        Icons.shield_rounded,
                        size: 29,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOVA VPN',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          'NEXT GENERATION PRIVACY',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white54,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: showSettings,
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 38),
                const Text(
                  'YOUR DIGITAL FREEDOM',
                  style: TextStyle(
                    color: blue,
                    letterSpacing: 3,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Explore Without Limits.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Secure. Private. Unlimited.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 42),
                AnimatedBuilder(
                  animation: pulse,
                  builder: (context, child) {
                    final glow = 20 + pulse.value * 25;
                    return Container(
                      width: 245,
                      height: 245,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: blue.withOpacity(
                            .25 + pulse.value * .35,
                          ),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: blue.withOpacity(.16),
                            blurRadius: glow,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: purple.withOpacity(.12),
                            blurRadius: glow,
                            spreadRadius: 12,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(17),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF438EFF),
                              Color(0xFF7547FF),
                              Color(0xFF321D83),
                            ],
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: connect,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.power_settings_new,
                                  size: 65,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'CONNECT',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'TAP TO CONNECT',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.whi
