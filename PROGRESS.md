# Bizniz Tracker - What's Done & What's Next

## 🎯 Current State (Nov 17, 2025)

Your **Bizniz Tracker** app is now a working Flutter MVP with:

✅ **Full Product Inventory System**
- Add/Edit/Delete products with auto-refresh UI
- Track cost price, selling price, quantity, min stock
- Persistent storage in Hive local database
- Clean architecture with Repository pattern

✅ **Sales Infrastructure Ready**
- Sale model with timestamp, product ref, quantity, revenue
- Sales repository with date filtering (by date, range, product ID)
- Hive persistence for sales logs
- DailySummary controller for analytics

✅ **Home Dashboard**
- Quick summary: Today's revenue, profit, sales count
- Low stock alerts highlighting items below minimum
- Navigation hub to all screens
- Async data loading with FutureBuilder

✅ **Clean Code Foundation**
- Riverpod providers for all dependencies
- Both Hive boxes (products & sales) initialized
- Code generation for Hive adapters (typeId: 0=Product, 1=Sale)
- Layer-based architecture (Domain/Data/Presentation)

---

## 🚧 What Needs Completing (Next 30 mins - 1 hour each)

### Priority 1: Add Sale Screen
Create the sales entry form:
1. Product dropdown (search/filter friendly)
2. Quantity input (validates vs available stock)
3. Selling price auto-filled (editable)
4. Confirm → save sale + reduce inventory + return home
5. Cancel → back to home

**File:** `lib/features/sales/presentation/add_sale_screen.dart` (placeholder exists)

---

### Priority 2: Sales Summary Screen
Analytics dashboard:
1. Daily/Weekly/Monthly tabs
2. Show: Total sales, revenue, profit, stock snapshot
3. Date range picker for custom filtering
4. Calculate: revenue (sum of sales), cost (qty × cost), profit

**File:** `lib/features/sales/presentation/sales_summary_screen.dart` (placeholder exists)

---

### Priority 3: Polish & Enhancements
- Low stock pop-up on app startup
- Low stock badges on inventory list
- Improved UI styling
- CSV export for backup/reporting

---

## 📂 Key File Locations

```
lib/
├── main.dart                           ← App entry & ProductHomePage (Inventory)
├── features/
│   ├── products/
│   │   ├── domain/product.dart        ← @HiveType ProductModel
│   │   ├── presentation/controllers.dart  ← ProductController
│   │   └── presentation/providers.dart   ← Riverpod DI
│   └── sales/
│       ├── domain/sale.dart           ← @HiveType Sale model
│       ├── presentation/
│       │   ├── sales_controller.dart  ← DailySummary logic
│       │   ├── home_screen.dart       ← ✅ Dashboard (done)
│       │   ├── add_sale_screen.dart   ← 🚧 Sales form (needs impl)
│       │   └── sales_summary_screen.dart ← 🚧 Analytics (needs impl)
│       └── data/sale_repository_impl.dart ← Hive persistence
└── core/
    ├── hive_registry.dart            ← Adapter registration
    └── failure.dart                  ← Error type
```

---

## 🎓 Quick Start for Next Dev

### Running the App
```bash
flutter run -d chrome
# or Windows, iOS, Android, etc.
```

### Adding Features
1. Data layer changes? Update `@HiveType` model + run:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. Adding UI screen?
   - Create `lib/features/<feature>/presentation/<screen_name>.dart`
   - Import `ProductController` and `SalesController` from providers
   - Use `setState()` to refresh after mutations

3. Testing sales flow:
   - Add a product via inventory (save qty=10, minStock=5)
   - Go to Add Sale, record a sale (qty=3)
   - Check Home → see revenue calculated
   - Check inventory → qty should be 7

---

## 💡 Design Decisions Made

1. **Plain ProductController** (not StateNotifier)
   - Reason: Simpler state management without Riverpod complexity
   - Refresh happens via `setState()` in UI, not reactive streams
   - Works well for simple CRUD

2. **Hive for persistence**
   - Reason: No external dependencies, fully offline, fast
   - Can export to CSV later if needed

3. **Clean Architecture**
   - Reason: Easy to test, maintain, scale
   - Clear separation: business logic (domain) vs storage vs UI

4. **FutureBuilder for analytics**
   - Reason: Daily summary requires querying both products and sales
   - Async pattern keeps UI responsive

---

## ✨ Example: How Add Sale Will Work

```dart
// User flow:
1. Tap FAB on Home → AddSaleScreen opens
2. Select product (dropdown shows all products)
3. Enter quantity (validated: qty ≤ available)
4. Selling price auto-filled from product.sellingPrice
5. Tap "Confirm Sale":
   a. Create Sale record (id, productId, qty, price, date, revenue)
   b. Save to Hive salesBox
   c. Update product.quantity -= qty
   d. Save updated product to Hive productsBox
   e. Close dialog, return to Home
   f. Home rebuilds → FutureBuilder recalculates summary ✓

// Controller pseudocode:
Future<void> recordSale(
  String productId,
  int quantitySold,
  double price,
) async {
  // 1. Create sale
  final sale = Sale(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    productId: productId,
    quantitySold: quantitySold,
    sellingPrice: price,
    saleDate: DateTime.now(),
    totalRevenue: quantitySold * price,
  );
  await saleRepository.addSale(sale);
  
  // 2. Update inventory
  final product = productController.state.products
    .firstWhere((p) => p.id == productId);
  final updated = product.copyWith(
    quantity: product.quantity - quantitySold,
  );
  await productController.updateProduct(updated);
}
```

---

## 🎉 You Now Have

- A **working inventory system** ✓
- A **sales logging foundation** ✓
- A **home dashboard** with real metrics ✓
- **Clean, testable code** ✓
- **Offline persistence** ✓
- A **clear roadmap** for finishing features ✓

**Time to completion:** ~2-3 hours for full MVP (Add Sale + Summary screens + polish)

---

**Need help? Check the ROADMAP.md for architecture details.**
