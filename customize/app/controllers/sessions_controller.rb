# coding: utf-8

class SessionsController < ApplicationController
  def create
    member = Member.authenticate(params[:login_id], params[:password])
    if member
      session[:member_id] = member.id
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to params[:from] || :root
  end

  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end
