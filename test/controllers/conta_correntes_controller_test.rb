require 'test_helper'

class ContaCorrentesControllerTest < ActionController::TestCase
  setup do
    @conta_corrente = conta_correntes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conta_correntes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conta_corrente" do
    assert_difference('ContaCorrente.count') do
      post :create, conta_corrente: { cliente_id: @conta_corrente.cliente_id, funcionario_id: @conta_corrente.funcionario_id, observacao: @conta_corrente.observacao, tipo_lancamento_id: @conta_corrente.tipo_lancamento_id, valor: @conta_corrente.valor }
    end

    assert_redirected_to conta_corrente_path(assigns(:conta_corrente))
  end

  test "should show conta_corrente" do
    get :show, id: @conta_corrente
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conta_corrente
    assert_response :success
  end

  test "should update conta_corrente" do
    patch :update, id: @conta_corrente, conta_corrente: { cliente_id: @conta_corrente.cliente_id, funcionario_id: @conta_corrente.funcionario_id, observacao: @conta_corrente.observacao, tipo_lancamento_id: @conta_corrente.tipo_lancamento_id, valor: @conta_corrente.valor }
    assert_redirected_to conta_corrente_path(assigns(:conta_corrente))
  end

  test "should destroy conta_corrente" do
    assert_difference('ContaCorrente.count', -1) do
      delete :destroy, id: @conta_corrente
    end

    assert_redirected_to conta_correntes_path
  end
end
