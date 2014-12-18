# coding: utf-8

class AccountsController < ApplicationController
  #個人情報編集フォーム
  def edit
    @member = @current_member
  end
end
