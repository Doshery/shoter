import pygame
import sys
from random import randint

pygame.init()
screen_width = 700
screen_height = 500
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Shooter")

fighter_image = pygame.image.load("fighter.png")
fighter_width, fighter_height = fighter_image.get_size()
fighter_x, fighter_y = screen_width/2 - fighter_width/2, screen_height - fighter_height
FIGHTER_STEP = 0.3
fighter_flag_l, fighter_flag_r = False, False

rocket_image = pygame.image.load("rocket.png")
rocket_width, rocket_height = rocket_image.get_size()
rocket_x, rocket_y = fighter_x + fighter_width/2 - rocket_width/2, screen_height - fighter_height - 20
rocket_flag = False
ROCKET_STEP = 0.4

alien_image = pygame.image.load("alien.png")
alien_width, alien_height = alien_image.get_size()
alien_x, alien_y = randint(0, screen_width-alien_width), 0
alien_flag = False
ALIEN_STEP = 0.2

GameIsRun = True
game_font = pygame.font.Font(None, 40)
count = 0

while GameIsRun:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_a or event.key == pygame.K_LEFT:
                fighter_flag_l = True
            if event.key == pygame.K_d or event.key == pygame.K_RIGHT:
                fighter_flag_r = True
            if event.key == pygame.K_SPACE:
                rocket_flag = True
                rocket_x, rocket_y = fighter_x + fighter_width / 2 - rocket_width / 2, screen_height - fighter_height - 20


        if event.type == pygame.KEYUP:
            fighter_flag_l = False
            fighter_flag_r = False


    if fighter_flag_l and fighter_x > 0:
        fighter_x -= FIGHTER_STEP
    if fighter_flag_r and fighter_x < screen_width - fighter_width:
        fighter_x += FIGHTER_STEP

    alien_y += ALIEN_STEP

    screen.fill((40, 10, 50))
    screen.blit(fighter_image, (fighter_x, fighter_y))

    if rocket_flag:
        screen.blit(rocket_image, (rocket_x, rocket_y))
        rocket_y -= ROCKET_STEP

    screen.blit(alien_image, (alien_x, alien_y))

    if rocket_flag and alien_x < rocket_x < alien_x + alien_width - rocket_width and rocket_y > alien_y and rocket_y < alien_y + alien_height - rocket_height:
        rocket_flag = False
        count += 1
        alien_x, alien_y = randint(0, screen_width - alien_width), 0
    text1 = game_font.render(f"Счет: {count}", True, "white")
    screen.blit(text1,(20,20))
    if alien_y + alien_height >= screen_height - fighter_height:
        screen.fill((250, 50, 50))

        text = game_font.render("Помер",True,'black')
        text_rect = text.get_rect()
        text_rect.center = screen_width/2 , screen_height/2
        screen.blit(text, text_rect)

    if event.type == pygame.KEYDOWN:
        if event.key == pygame.K_F1:
            text = 0
            screen.fill((40, 10, 50))
            alien_x, alien_y = randint(0, screen_width - alien_width), 0
            screen.blit(fighter_image, (fighter_x, fighter_y))



    pygame.display.update()
