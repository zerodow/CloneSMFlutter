import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  // Save intro seen state
  Future<void> _completeIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF8EE),
      body: Stack(
        children: [
          // PageView for swiping through pages
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              buildPage(
                image: "assets/images/splash1.png",
                text:
                    "Connect and take care of customers effectively with Smart Beauty.",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              buildPage(
                image: "assets/images/splash2.png",
                text: "Manage appointments with the most advanced functions.",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              buildPage(
                image: "assets/images/splash3.png",
                text: "All in one with Smart Beauty.",
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ],
          ),

          // Skip button (top-right)
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _completeIntro,
              child: const Text("Skip", style: TextStyle(color: Colors.black)),
            ),
          ),

          // Page Indicator & Navigation Buttons (bottom)
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // SmoothPageIndicator(
                //   controller: _pageController,
                //   count: 3,
                //   effect: ExpandingDotsEffect(
                //     dotHeight: 8,
                //     dotWidth: 8,
                //     activeDotColor: Colors.black,
                //   ),
                // ),
                // SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastPage) {
                        _completeIntro();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: Text(isLastPage ? "Start now" : "Next"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String text,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: screenWidth,
          // height: screenHeight * 0.6, // Adjust height to fit the screen
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
