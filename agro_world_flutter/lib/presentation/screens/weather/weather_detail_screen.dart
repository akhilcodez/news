import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/weather_model.dart';
import 'weather_forecast_screen.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel? weather;

  const WeatherDetailScreen({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    final data = weather;
    final tempStr = data != null ? "${data.temperature.toStringAsFixed(1)}°C" : "28.5°C";
    final descStr = data != null ? data.description : "Clear sky";
    final cityStr = data != null ? data.cityName : "Maharashtra Farming Zone";
    final humidityStr = data != null ? "${data.humidity}%" : "65%";
    final windStr = data != null ? "${data.windSpeed} m/s" : "4.2 m/s";
    final pressureStr = data != null ? "${data.pressure} hPa" : "1013 hPa";
    final latStr = data != null ? data.latitude.toStringAsFixed(4) : "19.0760";
    final lonStr = data != null ? data.longitude.toStringAsFixed(4) : "72.8777";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Climate & Weather"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Primary Weather Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDark.withOpacity(0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        cityStr,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.wb_sunny_rounded, size: 68, color: Color(0xFFFFD54F)),
                  const SizedBox(height: 10),
                  Text(
                    tempStr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    descStr[0].toUpperCase() + descStr.substring(1),
                    style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Meteorological Parameters Grid
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Meteorological Conditions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.45,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _metricCard(Icons.water_drop_outlined, "Humidity", humidityStr, const Color(0xFF0288D1)),
                _metricCard(Icons.air_rounded, "Wind Speed", windStr, const Color(0xFF00796B)),
                _metricCard(Icons.speed_rounded, "Atmospheric Pressure", pressureStr, const Color(0xFF7B1FA2)),
                _metricCard(Icons.wb_twilight_rounded, "Sunrise / Sunset", "06:15 AM / 06:40 PM", const Color(0xFFF57F17)),
                _metricCard(Icons.explore_outlined, "Latitude", latStr, const Color(0xFF455A64)),
                _metricCard(Icons.explore_outlined, "Longitude", lonStr, const Color(0xFF455A64)),
              ],
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WeatherForecastScreen()),
                  );
                },
                icon: const Icon(Icons.calendar_month_rounded),
                label: const Text("View 5-Day Hourly Forecast"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _metricCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
