# frozen_string_literal: true

class HeroesController < ApplicationController
  def index
    @heroes = Hero.includes(:powers).includes(:publisher).includes(:race).all
  end

  def show
    @hero = Hero.find(params[:id])
  end

  # GET /search/?search_term=user+search+term
  def search
    # DANGER: Vulnerable to SQL injections
    # @heroes = Hero.where("name LIKE '%#{params[:search_term]}%'")
    @heroes = Hero.where("name LIKE ?", "%#{params[:search_term]}%")
  end
end
