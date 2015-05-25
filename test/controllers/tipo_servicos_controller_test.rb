require 'test_helper'

class TipoServicosControllerTest < ActionController::TestCase
  setup do
    @tipo_servico = tipo_servicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_servicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_servico" do
    assert_difference('TipoServico.count') do
      post :create, tipo_servico: { ativo: @tipo_servico.ativo, descricao: @tipo_servico.descricao }
    end

    assert_redirected_to tipo_servico_path(assigns(:tipo_servico))
  end

  test "should show tipo_servico" do
    get :show, id: @tipo_servico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_servico
    assert_response :success
  end

  test "should update tipo_servico" do
    patch :update, id: @tipo_servico, tipo_servico: { ativo: @tipo_servico.ativo, descricao: @tipo_servico.descricao }
    assert_redirected_to tipo_servico_path(assigns(:tipo_servico))
  end

  test "should destroy tipo_servico" do
    assert_difference('TipoServico.count', -1) do
      delete :destroy, id: @tipo_servico
    end

    assert_redirected_to tipo_servicos_path
  end
end
