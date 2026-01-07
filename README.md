# ⭐ Starfall Catch

A fun and beautiful casual game built with Flutter and Flame engine. Catch falling stars with your golden basket and score as many points as possible!

[![Play Now](https://img.shields.io/badge/Play%20Now-Live%20Demo-brightgreen?style=for-the-badge)](https://game2-git-star-catcher-game-mahsanfurqans-projects.vercel.app/)
[![Flutter](https://img.shields.io/badge/Flutter-3.7.0-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)
[![Flame](https://img.shields.io/badge/Flame-1.30.1-FF6D00?style=for-the-badge)](https://flame-engine.org/)

## 🎮 Play Online

**[Click here to play the game!](https://game2-git-star-catcher-game-mahsanfurqans-projects.vercel.app/)**

## 📸 Screenshots

<!-- Add your screenshots here -->
![Game Screenshot](screenshots/gameplay.png)
*Catch colorful stars falling from the night sky!*

## ✨ Features

- 🌟 **Beautiful Graphics** - Stunning gradient backgrounds with glowing star effects
- 🎨 **Particle Effects** - Satisfying visual feedback when catching stars
- 💫 **3 Star Types** - Different colored stars with varying point values:
  - 🟡 Yellow stars: 10 points
  - 🔵 Cyan stars: 20 points
  - 🟣 Pink stars: 30 points
- ❤️ **3 Lives System** - Miss 3 stars and it's game over!
- 📈 **Progressive Difficulty** - Game gets faster as you play
- 🎯 **Multiple Control Options**:
  - Keyboard (Arrow keys or A/D)
  - Mouse/Touch (Click/tap to move)
- 🌐 **Web Support** - Play directly in your browser
- 📱 **Responsive Design** - Works on all screen sizes

## 🎯 How to Play

1. **Objective**: Catch as many falling stars as possible
2. **Controls**:
   - **Keyboard**: Use ← → arrow keys or A/D to move the basket
   - **Mouse**: Click anywhere on screen to move basket to that position
   - **Touch**: Tap on mobile devices
3. **Scoring**:
   - Yellow stars = 10 points
   - Cyan stars = 20 points
   - Pink stars = 30 points
4. **Lives**: You have 3 lives (hearts). Each missed star costs 1 life
5. **Game Over**: When all 3 lives are lost
6. **Restart**: Tap/click to play again after game over

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev) - Google's UI toolkit for building natively compiled applications
- **Game Engine**: [Flame](https://flame-engine.org/) - 2D game engine for Flutter
- **Deployment**: [Vercel](https://vercel.com) - For web hosting
- **Version Control**: Git & GitHub

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.7.0)
- Dart SDK
- Chrome (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mahsanfurqan/game2.git
   cd game2
   git checkout star-catcher-game
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the game**
   ```bash
   # For web (Chrome)
   flutter run -d chrome
   
   # For other platforms
   flutter run
   ```

### Build for Web

```bash
flutter build web --release
```

The built files will be in `build/web/` directory.

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
└── game/
    ├── star_catcher_game.dart   # Main game logic & rendering
    ├── basket.dart              # Player basket component
    ├── star.dart                # Falling star component
    ├── particle_effect.dart     # Visual effects
    ├── dino_game.dart          # (Legacy - alternative game)
    ├── player.dart             # (Legacy)
    ├── obstacle.dart           # (Legacy)
    └── ground.dart             # (Legacy)
```

## 🎨 Game Design

- **Background**: Beautiful gradient from dark purple to light purple (night sky theme)
- **Basket**: Golden basket with realistic shading and patterns
- **Stars**: 5-pointed stars with glow effects and rotation animations
- **Particles**: Explosion effect when catching stars
- **UI**: Clean score display and heart-shaped life indicators

## 🔧 Development

This game was built using:
- **Collision Detection**: Flame's built-in collision system
- **Physics**: Custom gravity implementation for falling stars
- **Input Handling**: Multi-input support (keyboard, mouse, touch)
- **Rendering**: Custom Canvas rendering for all game objects

## 📝 Future Improvements

- [ ] Power-ups (slow motion, extra life, score multiplier)
- [ ] Sound effects and background music
- [ ] Leaderboard system
- [ ] More star types and special stars
- [ ] Different difficulty levels
- [ ] Mobile app version (Android/iOS)
- [ ] Achievements system

## 🤝 Contributing

Contributions are welcome! Feel free to:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Mahsan Furqan**
- GitHub: [@mahsanfurqan](https://github.com/mahsanfurqan)

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev)
- Powered by [Flame Engine](https://flame-engine.org/)
- Deployed on [Vercel](https://vercel.com)

---

**[⭐ Play the Game Now!](https://game2-git-star-catcher-game-mahsanfurqans-projects.vercel.app/)**

*If you enjoyed this game, please give it a star on GitHub!* ⭐
