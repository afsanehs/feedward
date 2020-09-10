Chartkick.options = {
  height: "400px",
  colors: ["#6bb07d", "#22347a", "#b2b3e7", "B2ACFA", "#e8a045", "#f44336"]
}

Chartkick.options[:html] = '<div id="%{id}" style="height: %{height};">Loading...</div>'

Chartkick.options[:content_for] = :charts_js
