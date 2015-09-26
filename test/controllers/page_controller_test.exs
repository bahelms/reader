defmodule Reader.PageControllerTest do
  use Reader.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Select a category"
  end
end
