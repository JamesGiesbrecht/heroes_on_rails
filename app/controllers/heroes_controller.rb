# frozen_string_literal: true

class HeroesController < ApplicationController
  def index
    @heroes = Hero.includes(:powers).includes(:publisher).includes(:race).all
  end
end
