
### How to use

## 1, use CustomThemeProvider to wrap your app

```
runApp(
  CustomThemeProvider(
    child: MyApp(),
  )
);
```

## 2, mixin CustomThemeSwitchingMixin to your StatefulWidget

```
class _TabTodayComponentState extends State<TabTodayComponent> with CustomThemeSwitchingMixin<TabTodayComponent> {
  
  @override
  Widget buildWithTheme(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
  
}
```

## 3, create CustomThemeSwitchingWidget or CustomThemeSwitcher to switch theme

```
Widget _buildContent(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: _buildTabView(context),
        bottomNavigationBar: _buildBottomNav(context),
        floatingActionButton: const CustomThemeSwitcher(),
    );
}
```