require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  def new_product(image_url)
    Product.new(title: "My Book Title", description: "yyy", image_url: image_url, price: 49.90)
  end

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "test price must be positive" do
    product = new_product("zzz.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w[ fred.gif fred.jpg fred.png FRED.JPG RRED.Jpg http://a.b.c/x/y/z/fred.gif]
    bad = %w[ fred.doc fred.gif/more fred.gif.more ]

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test "product is not valid without a unique name" do
    product = new_product("zzz.jpg")
    product.title = products(:ruby).title

    assert product.invalid?
    assert_equal [ "has already been taken" ], product.errors[:title]
  end

  test "product title length should be aleast 10" do
    product = new_product("zzz.jpg")
    product.title = "ksdj"

    assert product.invalid?
    assert_equal [ "length should be atreat 10." ], product.errors[:title]

    product.title = "1234567891"
    assert product.valid?
  end
end
