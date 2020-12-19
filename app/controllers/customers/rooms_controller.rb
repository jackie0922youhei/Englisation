class Customers::RoomsController < ApplicationController
  def index
    @current_entries = current_customer.entries
    # @current_entriesのルームを配列にする
    current_room_ids = []
    @current_entries.each do |current_entry|
      current_room_ids << current_entry.room.id
    end
    # @current_entriesのルーム且つcurrent_customerでないEntryを新着順で取ってくる
    @another_entries = Entry.where(room_id: current_room_ids).where.not(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    # ルームが作成されているかどうか
    if Entry.where(:customer_id => current_customer.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    # entryにログインユーザーを作成
    @entry1 = Entry.create(:room_id => @room.id, :customer_id => current_customer.id)
    # entryにparamsユーザーを作成
    @entry2 = Entry.create(params.require(:entry).permit(:customer_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to room_index_path
  end
end
