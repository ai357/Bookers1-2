class BooksController < ApplicationController

  # 一覧ページ
  def index
    @book = Book.new
    @books = Book.all
  end

  # 詳細ページ
  def show
    @book = Book.find(params[:id])
  end

  # 編集ページ
  def edit
    @book = Book.find(params[:id])
  end

  # 削除機能
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  # 投稿機能 　
  def create
    # Bookモデルにデータを入れる枠を作成（空のインスタンスを作成）
    @book = Book.new(book_params)
    # 保存に成功した場合
    if @book.save
       redirect_to book_path(@book.id), notice: "notice:Book was successfully created."
    # 保存に失敗した場合
    else
      # Bookモデルに入っているデータすべて
       @books = Book.all
       render :index
    end
  end

  # 更新
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id), notice: "notice:Book was successfully updated."
    else
       render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
