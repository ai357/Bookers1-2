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
    # bookモデルから１つ探す
    book = Book.find(params[:id])
    # 探したデータを削除（物理削除）
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
      # 一覧ページに遷移
       render :index
    end
  end

  # 更新
  def update
    # Bookモデルにあるデータから１つ探す
    @book = Book.find(params[:id])
    # データを更新
    if @book.update(book_params)
      # book/viewに遷移し、お知らせを
       redirect_to book_path(@book.id), notice: "notice:Book was successfully updated."
    else
      # 編集ページに遷移
       render :edit
    end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
