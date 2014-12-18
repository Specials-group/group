# coding: utf-8

class Admin::MembersController < Admin::Base
  # 会員一覧
  def index
#    @members = Member.order("number").
    @members = Member.order("id")
#      paginate(page: params[:page], per_page: 15)
  end

  # 会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end
end
