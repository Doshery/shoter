import pygame
import sys
from random import randint

pygame.init()
screen_width = 700
screen_height = 700
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Shooter")

fighter_image = pygame.image.load("images/fighter.png")
fighter_width, fighter_height = fighter_image.get_size()
fighter_x, fighter_y = screen_width/2 - fighter_width/2, screen_height - fighter_height
FIGHTER_STEP = 1
fighter_x_l, fighter_x_r = False, False

rocket_image = pygame.image.load("images/rocket.png")
rocket_width, rocket_height = rocket_image.get_size()
rocket_flag = False
ROCKET_STEP = 1

alien_image = pygame.image.load("images/alien.png")
alien_width, alien_height = alien_image.get_size()
alien_x = randint(0,screen_width - alien_width)
alien_y = 0
ALIEN_STEP = 0.3

gameisrun = True
while gameisrun:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            sys.exit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                fighter_x_l = True
            if event.key == pygame.K_RIGHT:
                fighter_x_r = True
            if event.key == pygame.K_SPACE:
                rocket_flag = True
                rocket_x = fighter_x + fighter_width / 2 - rocket_width / 2
                rocket_y = screen_width - fighter_width
        if event.type == pygame.KEYUP:
            fighter_x_l = False
            fighter_x_r = False

    if fighter_x_l and fighter_x > 0:
        fighter_x -= FIGHTER_STEP
    if fighter_x_r and fighter_x < screen_width - fighter_width:
        fighter_x += FIGHTER_STEP

    screen.fill((0, 250, 200))
    screen.blit(fighter_image, (fighter_x, fighter_y))
    if rocket_flag:
        screen.blit(rocket_image, (rocket_x, rocket_y))
        rocket_y -= ROCKET_STEP

    alien_y += ALIEN_STEP

    screen.blit(alien_image, (alien_x, alien_y))
    if alien_y + alien_height >= screen_height -fighter_height:
        game_font = pygame.font.Font(None,40)
        text = game_font.render("you lose >:)")

        gameisrun = False


    pygame.display.update()

