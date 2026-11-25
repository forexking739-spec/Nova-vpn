
import 'package:flutter/material.dart';

void main() => runApp(const NovaApp());

const bg = Color(0xFF060916);
const blue = Color(0xFF398BFF);
const purple = Color(0xFF914DFF);
const card = Color(0xFF111A30);

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class Server {
  final String name, flag, city;
  const Server(this.name, this.flag, this.city);
}

class NovaHome extends StatefulWidget {
  const NovaHome({super.key});

  @override
  State<NovaHome> createState() => _NovaHomeState();
}

class _NovaHomeState extends State<NovaHome>
    with SingleTickerProviderStateMixin {

  late AnimationController pulse;

  bool connected = false;

  Server selected = const Server(
    'Germany', '🇩🇪', 'Frankfurt'
  );

  final servers = const [
    Server('United States', '🇺🇸', 'New York'),
    Server('United Kingdom', '🇬🇧', 'London'),
    Server('Germany', '🇩🇪', 'Frankfurt'),
    Server('Singapore', '🇸🇬', 'Singapore'),
  ];

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

  void showServers() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101A32),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Choose your location',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              ...servers.map((s) => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5),
                leading: Text(
                  s.flag,
                  style: const TextStyle(fontSize: 30),
                ),
                title: Text(
                  s.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  s.city,
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
                trailing: selected.name == s.name
                    ? const Icon(
                        Icons.check_circle,
                        color: blue,
                      )
                    : const Icon(
                        Icons.chevron_right,
                        color: Colors.white38,
                      ),
                onTap: () {
                  setState(() {
                    selected = s;
                    connected = false;
                  });
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void connect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: card,
        content: Text(
          'WireGuard server configuration required. '
          'VPN connection is not active yet.',
        ),
      ),
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
            padding: const EdgeInsets.fromLTRB(
              22, 18, 22, 25,
            ),
            child: Column(
              children: [

                // HEADER

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
                        boxShadow: [
                          BoxShadow(
                            color: blue.withOpacity(.35),
                            blurRadius: 18,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shield_rounded,
                        size: 29,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.06),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: Colors.white12,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 38),

                // TITLE

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
                    letterSpacing: -.5,
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

                // CONNECT BUTTON

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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
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
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.power_settings_new,
                                  size: 65,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  connected
                                      ? 'CONNECTED'
                                      : 'CONNECT',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 3,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'TAP TO CONNECT',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white70,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 26),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.05),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 9),
                      const Text(
                        'NOT CONNECTED',
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 2,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 38),

                // SERVER SECTION

                Row(
                  children: [
                    const Text(
                      'SERVER LOCATION',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '4 LOCATIONS',
                      style: TextStyle(
                        fontSize: 10,
                        color: blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                InkWell(
                  onTap: showServers,
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    padding: const EdgeInsets.all(19),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.055),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: blue.withOpacity(.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: blue.withOpacity(.06),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          selected.flag,
                          style: const TextStyle(fontSize: 38),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                selected.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                selected.city,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: blue,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // INFORMATION CARDS

                Row(
                  children: [
                    Expanded(
                      child: infoCard(
                        Icons.speed_rounded,
                        'LIVE PING',
                        '-- ms',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: infoCard(
                        Icons.security_rounded,
                        'PROTOCOL',
                        'WireGuard',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // BOTTOM BRAND

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: blue,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'POWERED BY NOVA TECHNOLOGY',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.35),
                        fontSize: 9,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.055),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.09),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: blue, size: 27),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
