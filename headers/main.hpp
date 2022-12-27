#ifndef MAIN_H
#define MAIN_H

#include <SFML/Audio.hpp>
#include <SFML/Graphics.hpp>
#include <iostream>

sf::Clock g_Clock;
float g_Speed = 100.0f; // pixels per second
sf::Vector2f g_TextPos(0.0f, 0.0f);

float updateTextPosition(sf::Text &text)
{
  float elapsedTime = g_Clock.restart().asSeconds();
  g_TextPos.x += elapsedTime * g_Speed;
  if (g_TextPos.x > 640.0f)
  {
    g_TextPos.x = 0.0f;
  }
  text.setPosition(g_TextPos);
  return elapsedTime;
}

#endif // MAIN_H
