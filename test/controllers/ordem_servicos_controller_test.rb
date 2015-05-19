require 'test_helper'

class OrdemServicosControllerTest < ActionController::TestCase
  setup do
    @ordem_servico = ordem_servicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordem_servicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordem_servico" do
    assert_difference('OrdemServico.count') do
      post :create, ordem_servico: { cliente_id: @ordem_servico.cliente_id, valor: @ordem_servico.valor }
    end

    assert_redirected_to ordem_servico_path(assigns(:ordem_servico))
  end

  test "should show ordem_servico" do
    get :show, id: @ordem_servico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ordem_servico
    assert_response :success
  end

  test "should update ordem_servico" do
    patch :update, id: @ordem_servico, ordem_servico: { cliente_id: @ordem_servico.cliente_id, valor: @ordem_servico.valor }
    assert_redirected_to ordem_servico_path(assigns(:ordem_servico))
  end

  test "should destroy ordem_servico" do
    assert_difference('OrdemServico.count', -1) do
      delete :destroy, id: @ordem_servico
    end

    assert_redirected_to ordem_servicos_path
  end
end
