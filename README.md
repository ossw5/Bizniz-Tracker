# Bizniz Tracker

A lightweight, offline-first Flutter app for small business inventory and sales tracking. Manage products, log sales, view analytics, and export data—all stored locally on your device.

## Features

### 📦 Inventory Management
- Add, edit, and delete products with cost & selling prices
- Track stock levels in real-time
- Set minimum stock thresholds and receive low-stock alerts
- Organize products by categories with quick filter chips
- View product details (ID, quantity, cost, selling price, category)

### 💰 Sales Logging
- Record sales with a searchable product selector (search by name, ID, or category)
- Validate against available stock to prevent overselling
- Automatic inventory reduction after each sale
- Set custom selling price per transaction
- Total revenue calculation

### 📊 Analytics Dashboard
- Daily sales summary (revenue, profit, sales count)
- Low-stock alerts with quick navigation to inventory
- Tabbed sales analytics (Daily / Weekly / Monthly)
- Cost breakdown and profit tracking

### 📤 Data Export
- Export inventory as CSV (products with stock levels, costs, prices)
- Export sales logs as CSV (transaction history with timestamps and revenue)
- Saved to device Downloads or app documents directory

### 🎨 Modern UI
- Minimalist design with a custom color palette (#005057, #00777E, #4B3217, #785230, #AE9276)
- Currency formatting for Philippine Peso (₱)
- Theme-driven colors and typography for consistency
- Responsive Material Design layout

### 💾 Offline Storage
- Uses Hive database for local, fast data persistence
- No internet required—all data stays on your device
- Works on Android, iOS, Windows, macOS, Linux, and web

## How to Use

1. **Add Products**: Go to Inventory → Tap + → Fill in product details (name, quantity, cost, selling price, category, min stock).
2. **Log Sales**: Tap "Add Sale" → Search and select product → Enter quantity & price → Confirm. Inventory auto-updates.
3. **View Analytics**: Check Dashboard for today's summary and low-stock alerts, or tap Summary to see weekly/monthly trends.
4. **Export Data**: Tap the download icon on Inventory or Summary screens to export CSV files.
5. **Manage Categories**: Use category chips on Inventory to filter by product type or tap + to add new categories.

## Getting Started

### Prerequisites
- Flutter 3.32.8+ (stable channel)
- Android SDK 30+ or iOS 12+
- Dart 3.8.1+

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ossw5/Bizniz-Tracker.git
   cd Bizniz-Tracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run on a device/emulator:
   ```bash
   flutter run
   ```

4. Build a release APK (Android):
   ```bash
   flutter build apk --release
   ```

### Tech Stack
- **Framework**: Flutter (cross-platform UI)
- **State Management**: Riverpod (DI & providers)
- **Database**: Hive (local persistence)
- **Currency**: Intl (Philippine Peso formatting)
- **Code Generation**: Hive adapters, build_runner

## Project Structure
```
lib/
├── main.dart                          # App entry & navigation
├── core/
│   ├── theme.dart                     # Minimalist theme & palette
│   ├── formatters.dart                # Currency formatting (₱)
│   ├── csv_export.dart                # CSV generation & export
│   ├── hive_registry.dart             # Hive setup
│   └── failure.dart                   # Error handling
├── features/
│   ├── products/
│   │   ├── domain/                    # Product model
│   │   ├── data/                      # Local datasource & repository
│   │   └── presentation/              # Controllers & providers
│   └── sales/
│       ├── domain/                    # Sale model & repository interface
│       ├── data/                      # Sales repository impl
│       └── presentation/              # Screens & sales controller
```

## Future Enhancements
- Push notifications for low-stock alerts
- Multi-user support with cloud sync
- Advanced analytics (charts, trends, forecasting)
- Barcode scanning for faster product entry
- Play Store distribution

## License
MIT License — feel free to use and modify this project.

## Support
For issues or feature requests, open an issue on GitHub or contact the maintainer.
