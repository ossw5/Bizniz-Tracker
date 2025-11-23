# Bizniz Tracker - MVP Development Roadmap

## Project Overview
A Flutter-based offline inventory and sales tracking app for small businesses. Track products, log sales, and view daily/weekly/monthly analytics with local Hive database storage.

---

## ✅ Completed Features

### 1. **Product Catalog / Inventory** (Core Feature)
- ✅ Add, edit, delete products
- ✅ Track quantity, cost price, selling price
- ✅ Categorize items
- ✅ Set minimum stock threshold
- ✅ Hive persistence layer with TypeAdapter
- ✅ Product Repository (add, update, delete, getAll, getById)
- ✅ Inventory List Screen with product display

### 2. **Sales Logging Infrastructure**
- ✅ Sale entity with Hive support (typeId: 1)
- ✅ Sale Repository with date range queries
- ✅ Sales data persistence in Hive
- ✅ Automatic calculation of revenue (qty × price)
- ✅ Query sales by date, date range, or product ID

### 3. **Home Screen / Dashboard**
- ✅ Daily summary cards: Total revenue, profit, sales count
- ✅ Low stock alerts highlighting items below minimum
- ✅ Quick navigation via bottom navigation bar (4 screens)
- ✅ FutureBuilder for async data loading

### 4. **Architecture & Providers**
- ✅ Clean architecture (Domain, Data, Presentation layers)
- ✅ Riverpod providers for dependency injection
- ✅ Hive boxes registered and accessible via providers
- ✅ Both products and sales boxes opened at app startup

---

## 🚧 In Progress / Next Steps

### 3. **Add Sale Screen** (Priority: HIGH)
**Location:** `lib/features/sales/presentation/add_sale_screen.dart`

**Requirements:**
- Product dropdown selector (search/filter by name)
- Quantity input field
- Auto-filled selling price (editable)
- Confirm Sale button → triggers:
  - Create Sale record in Hive
  - Reduce product quantity in inventory
  - Return to Home Screen with refreshed summary
- Cancel button → back to Home

**Implementation Notes:**
- Use `productController.state.products` for dropdown
- Create `SalesController.recordSale()` method
- Update inventory: `product.quantity -= quantitySold`
- Emit refresh event to update Home Screen summary

---

### 4. **Sales Summary Screen** (Priority: HIGH)
**Location:** `lib/features/sales/presentation/sales_summary_screen.dart`

**Requirements:**
- Tab selector: Daily / Weekly / Monthly views
- Display metrics:
  - Total sales count
  - Total revenue
  - Total cost (sum of qty × cost_price for sold items)
  - Profit (revenue - cost)
  - Current stock levels (by product)
- Date range picker for custom filtering
- Optional: Chart/graph visualization

**Implementation Notes:**
- Use `SaleRepositoryImpl.getSalesByDateRange()`
- Calculate totals by filtering sales + matching product costs
- Format dates using `intl` package

---

### 5. **Low Stock Alerts** (Priority: MEDIUM)
**Location:** Currently partial in `HomeScreen` via `DailySummary`

**Requirements:**
- Already detects low stock in Home Screen
- Add optional: Pop-up alert when app starts if items are below minimum
- Show a dismissed/persistent banner on Home Screen

**Implementation Notes:**
- Check in `didChangeDependencies` or `initState`
- Trigger `showDialog()` if any `product.quantity < product.minStock`
- Allow user to dismiss or go to Inventory

---

### 6. **Enhance Inventory Screen** (Priority: MEDIUM)
**Location:** `lib/main.dart` - `ProductHomePage`

**Current State:** Basic list with add/edit/delete per product

**Improvements:**
- Add low stock indicator badge (red badge if qty < minStock)
- Show quick stats: quantity/minStock ratio
- Swipe-to-delete or context menu improvements
- Sort by: name, quantity, low stock first

---

### 7. **CSV Export Feature** (Priority: LOW)
**Location:** New file: `lib/features/core/csv_exporter.dart`

**Requirements:**
- Export inventory data (name, qty, cost, selling price, category)
- Export sales log (product, qty sold, price, date, revenue)
- Save to Downloads folder or share via email
- Use `csv` package from pub.dev

---

## 🏗️ Architecture Overview

```
lib/
├── core/
│   ├── failure.dart              # Error handling
│   ├── hive_registry.dart        # Hive adapter registration
│   └── csv_exporter.dart         # [TODO]
├── features/
│   ├── products/
│   │   ├── domain/
│   │   │   ├── product.dart      # ProductModel with @HiveType
│   │   │   └── repositories.dart
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── product_local_datasource_impl.dart
│   │   │   └── repositories/
│   │   │       └── product_repository_impl.dart
│   │   └── presentation/
│   │       ├── controllers.dart  # ProductController
│   │       └── providers.dart    # Riverpod providers
│   └── sales/
│       ├── domain/
│       │   ├── sale.dart         # Sale model with @HiveType
│       │   └── sale_repository.dart
│       ├── data/
│       │   └── sale_repository_impl.dart
│       └── presentation/
│           ├── sales_controller.dart     # DailySummary logic
│           ├── home_screen.dart         # Dashboard
│           ├── add_sale_screen.dart     # [WIP]
│           └── sales_summary_screen.dart # [WIP]
└── main.dart                    # App entry & navigation
```

---

## 📱 User Flow

1. **Home Screen (Dashboard)**
   - Opens on app launch
   - Shows today's totals + low stock alerts
   - Navigate to Inventory, Add Sale, or Sales Summary via bottom nav

2. **Inventory Screen**
   - View all products with stock indicators
   - Tap to edit, delete, or view product details
   - Add new product button

3. **Add Sale Screen**
   - Select product from dropdown
   - Enter quantity sold (validates against available stock)
   - Auto-fill selling price, allow override
   - Confirm → updates inventory, logs sale, returns to Home

4. **Sales Summary Screen**
   - Toggle: Daily / Weekly / Monthly
   - See revenue, profit, sales count, stock snapshot
   - Optional date range filter

---

## 🔧 Technical Stack

- **Frontend:** Flutter 3.x
- **State Management:** Riverpod + StateNotifier
- **Local Database:** Hive with code generation
- **Architecture:** Clean Architecture (Domain/Data/Presentation)
- **Dependencies:**
  - `flutter_riverpod` - state management
  - `hive` + `hive_flutter` - local storage
  - `dartz` - Either for error handling
  - `build_runner` + `hive_generator` - code generation
  - `intl` - date formatting
  - `csv` - CSV export (to add)

---

## 🚀 Next Immediate Steps

1. **Implement Add Sale Screen** → Connects sales logging to inventory updates
2. **Build Sales Summary Screen** → Queries and displays aggregated metrics
3. **Test full sales workflow** → Record sale → see inventory decrease → see summary update
4. **Add low stock pop-ups** → Notification system
5. **CSV export** → Backup and external reporting

---

## 📝 Notes for Developers

- Always update `Hive.registerAdapter()` when adding new `@HiveType` models
- Run `flutter pub run build_runner build --delete-conflicting-outputs` after schema changes
- Use Riverpod providers for dependency injection; avoid direct instantiation
- Test with actual Hive persistence (not just in-memory mock)
- Consider adding unit tests for repository + controller logic

---

**Last Updated:** Nov 17, 2025  
**Status:** MVP Phase - Core foundation complete, now implementing sales workflow
