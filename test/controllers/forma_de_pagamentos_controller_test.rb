require 'test_helper'

class FormaDePagamentosControllerTest < ActionController::TestCase
  setup do
    @forma_de_pagamento = forma_de_pagamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forma_de_pagamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create forma_de_pagamento" do
    assert_difference('FormaDePagamento.count') do
      post :create, forma_de_pagamento: { descricao: @forma_de_pagamento.descricao }
    end

    assert_redirected_to forma_de_pagamento_path(assigns(:forma_de_pagamento))
  end

  test "should show forma_de_pagamento" do
    get :show, id: @forma_de_pagamento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @forma_de_pagamento
    assert_response :success
  end

  test "should update forma_de_pagamento" do
    patch :update, id: @forma_de_pagamento, forma_de_pagamento: { descricao: @forma_de_pagamento.descricao }
    assert_redirected_to forma_de_pagamento_path(assigns(:forma_de_pagamento))
  end

  test "should destroy forma_de_pagamento" do
    assert_difference('FormaDePagamento.count', -1) do
      delete :destroy, id: @forma_de_pagamento
    end

    assert_redirected_to forma_de_pagamentos_path
  end
end
