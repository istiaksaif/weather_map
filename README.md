# Weather Forecast Application

This is a weather forecast application built using **Flutter**. The app dynamically fetches current location weather info from a provided API and displays them in a scrollable list. Also forecast list fetch from api. User can search weather info using city name. Each Day forecast details also can view on details screen.

## Features

- **Weather**
    - Fetch current location and get lat long
    - Using lat long value fetch current location weather
- **Forecast**
    - Same as Weather fetch Forecast system, Fetch current location and get lat long
    - Using lat long value fetch current location forecast
- **Search Weather Info**
    - Fetch weather info using city name.
    - Save success city weather saved on local storage. So that user can view the search history
- **Interactive UI**
    - Multiple custom icons for enhanced visual consistency.
    - Responsive design built with Flutter.
- **State Management**
    - Efficient and reactive state management powered by RiverPod.

## Getting Started

### Prerequisites

- [Flutter SDK](Flutter 3.29.2 • channel stable https://flutter.dev/docs/get-started/install) (latest stable version recommended)
- Dart SDK (Dart SDK version: 3.7.2)
- An IDE like Android Studio, VS Code

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/istiaksaif/weather_map.git

### Folders Breakdown

<ul>
  <li><strong>lib/</strong></li>
  <ul>
    <li><strong>controller/</strong> - riverpod controllers for managing state (e.g., weather,forecast,search)</li>
    <li><strong>core/</strong> - API clients and networking logic when failed due to network</li>
    <ul>
      <li><strong>api/</strong> - API clients and networking logic when failed due to network</li>
      <li><strong>utils/</strong> - Utility functions, constants, and helper classes</li>
    </ul>
    <li><strong>route/</strong> - Application navigation logic</li>
    <li><strong>model/</strong> - Data models (e.g., ForecastModel, WeatherModel) that define the data structure</li>
    <li><strong>view/</strong> - UI screens and pages</li>
    <ul>
      <li><strong>screen/</strong> - Main screens of the app (e.g., home, forecast daily details, search)</li>
      <li><strong>widget/</strong> - Reusable widgets, buttons, custom inputs fields, app bars</li>
    </ul>
  </ul>
</ul>