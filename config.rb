###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# お絵かきチャットログ個別ページを動的に生成する
logDir = './source/paintchatlog/'
Dir::foreach(logDir) do |f|
  if f == '.' || f == '..' then
    next
  end

  if FileTest::directory?(File.join(logDir, f)) then
    print "proxy :#{File.join(logDir, f)}"

    # ディレクトリ内の画像ファイル一覧を各ページに渡す
    layers = Dir.glob(File.join(logDir, f, "*.png"))
    print layers

    proxy "/paintchatlog/#{f}/index.html", "/logviewer.html", :locals => {:datestr => f, :layers => layers}, :ignore => true
  end
end

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, :host => "localhost"
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# 相対パスにする
activate :relative_assets
set :relative_links, true
