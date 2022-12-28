#include "../headers/main.hpp"

int main()
{
  // Memuat musik dan mengatur looping
  sf::Music music;
  if (!music.openFromFile("../assets/audio/backsound.wav"))
  {
    std::cerr << "Error loading music" << std::endl;
    return 1;
  }
  music.setLoop(true);
  music.play();

  // Membuat window dan mengatur judul
  sf::RenderWindow window(sf::VideoMode(640, 480), "SFML Example");

  // Membuat teks dan mengatur font
  sf::Font font;
  if (!font.loadFromFile("../assets/font/DCC.otf"))
  {
    std::cerr << "Error loading font" << std::endl;
    return 1;
  }
  sf::Text text("SFML Example", font, 24);
  text.setFillColor(sf::Color::White);
  text.setOutlineColor(sf::Color::Black);
  text.setOutlineThickness(2.0f);

  // Game loop
  while (window.isOpen())
  {
    // Memproses input
    sf::Event event;
    while (window.pollEvent(event))
    {
      if (event.type == sf::Event::Closed)
      {
        window.close();
      }
    }

    // Mengupdate posisi teks
    float elapsedTime = updateTextPosition(text);

    // Menggambar window
    window.clear(sf::Color::Black);
    window.draw(text);
    window.display();
  }

  return 0;
}
