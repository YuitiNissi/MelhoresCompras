-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-09-11 21:02:39 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_mc_categoria_produto CASCADE CONSTRAINTS;

DROP TABLE t_mc_chamado_sac CASCADE CONSTRAINTS;

DROP TABLE t_mc_classificacao_video CASCADE CONSTRAINTS;

DROP TABLE t_mc_cliente CASCADE CONSTRAINTS;

DROP TABLE t_mc_codigo_postal CASCADE CONSTRAINTS;

DROP TABLE t_mc_departamento CASCADE CONSTRAINTS;

DROP TABLE t_mc_endereco_cliente CASCADE CONSTRAINTS;

DROP TABLE t_mc_endereco_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_mc_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_mc_p_fisica CASCADE CONSTRAINTS;

DROP TABLE t_mc_p_juridica CASCADE CONSTRAINTS;

DROP TABLE t_mc_produto CASCADE CONSTRAINTS;

DROP TABLE t_mc_video_produto CASCADE CONSTRAINTS;

DROP TABLE t_mc_visualizacao_video CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_mc_categoria_produto (
    nm_categoria_produto VARCHAR2(50) NOT NULL,
    ds_categoria         VARCHAR2(250),
    st_categoria         CHAR(1) NOT NULL,
    dt_inicio            DATE NOT NULL,
    dt_termino           DATE
);

ALTER TABLE t_mc_categoria_produto ADD ( cd_categoria_produto NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_categoria_produto.cd_categoria_produto IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_categoria_produto.nm_categoria_produto IS
    'Capitular: nome simples da categoria do produto.';

COMMENT ON COLUMN t_mc_categoria_produto.ds_categoria IS
    'Capitular: descrição mais completa da categoria do produto.';

COMMENT ON COLUMN t_mc_categoria_produto.st_categoria IS
    'Capitular status do vídeo: "A"tivo ou "I"nativo. CHAR1';

COMMENT ON COLUMN t_mc_categoria_produto.dt_inicio IS
    'DD/MM/AAAA dt_inicio: data do cadastro da categoria do produto';

COMMENT ON COLUMN t_mc_categoria_produto.dt_termino IS
    'DD/MM/AAAA dt_termino: data de inativação da categoria do produto.';

ALTER TABLE t_mc_categoria_produto
    ADD CONSTRAINT ck_mc_categoria_produto_status CHECK ( st_categoria IN ( 'A', 'I' ) );

ALTER TABLE t_mc_categoria_produto ADD CONSTRAINT un_mc_cat_prod_nome UNIQUE ( nm_categoria_produto );

CREATE TABLE t_mc_chamado_sac (
    cd_cliente                INTEGER NOT NULL,
    cd_produto                INTEGER NOT NULL,
    cd_funcionario            INTEGER NOT NULL,
    tp_chamado                CHAR(1) NOT NULL,
    dt_abertura               DATE NOT NULL,
    dt_atendimento_inicial    DATE,
    ds_chamado_cliente        VARCHAR2(4000) NOT NULL,
    ds_retorno                CLOB,
    dt_atendimento_finalizado DATE,
    st_chamado                CHAR(1) NOT NULL,
    in_satisfacao_cliente     NUMBER(2)
);

ALTER TABLE t_mc_chamado_sac ADD ( cd_chamado_sac NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_chamado_sac.cd_chamado_sac IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_chamado_sac.tp_chamado IS
    'Tipo "1" Sugestão
Tipo "2" Reclamação
Classificação obrigatória
';

COMMENT ON COLUMN t_mc_chamado_sac.dt_abertura IS
    'DD/MM/AAAA HH:MM:SS quando o cliente abre o chamado';

COMMENT ON COLUMN t_mc_chamado_sac.dt_atendimento_inicial IS
    'D/MM/AAAA HH:MM:SSquando o funcionário retorna o chamado pela primeira vez';

COMMENT ON COLUMN t_mc_chamado_sac.ds_chamado_cliente IS
    'Capitular descrição da sugestão ou reclamação preenchida pelo usuário: campo obrigatório.';

COMMENT ON COLUMN t_mc_chamado_sac.ds_retorno IS
    'Capitular descrição do atendimento e solução preenchida pelo funcionário.';

COMMENT ON COLUMN t_mc_chamado_sac.dt_atendimento_finalizado IS
    'dt final: DD/MM/AAAA HH:MM:SS quando o chamado é finalizado. Calcular o tempo decorrido ente a data de abertura e a finalização medido horas (RN16)'
    ;

COMMENT ON COLUMN t_mc_chamado_sac.st_chamado IS
    'Capitular status chamado: "A"berto, "E"m atendimento, "C"ancelado, "F"echado com sucesso, "X" finalizado com insatisfação do cliente.'
    ;

COMMENT ON COLUMN t_mc_chamado_sac.in_satisfacao_cliente IS
    'Capitular índice de satisfação do cliente: programado em python. De 1 a 6: Insatisfação, 7 a 8, Neutro, 9 a 10, Satisfação.';

ALTER TABLE t_mc_chamado_sac
    ADD CONSTRAINT ck_mc_chamado_sac_status CHECK ( st_chamado IN ( 'A', 'E', 'C', 'F', 'X' ) );

CREATE TABLE t_mc_classificacao_video (
    nm_classificacao_video VARCHAR2(30) NOT NULL,
    ds_classificacao_video VARCHAR2(255)
);

ALTER TABLE t_mc_classificacao_video ADD ( cd_classificacao_video NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_classificacao_video.cd_classificacao_video IS
    'Código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_classificacao_video.nm_classificacao_video IS
    'Capitular: nome simples da classificação do vídeo.';

COMMENT ON COLUMN t_mc_classificacao_video.ds_classificacao_video IS
    'Descrição mais completa sobre a classificação, se necessário.';

ALTER TABLE t_mc_classificacao_video ADD CONSTRAINT un_mc_class_vid_nome UNIQUE ( nm_classificacao_video );

ALTER TABLE t_mc_classificacao_video ADD CONSTRAINT un_mc_class_vid_descricao UNIQUE ( ds_classificacao_video );

CREATE TABLE t_mc_cliente (
    tp_pessoa   CHAR(1) NOT NULL,
    nm_cliente  VARCHAR2(50) NOT NULL,
    qt_estrelas NUMBER(1),
    st_cliente  CHAR(1) NOT NULL,
    ds_email    VARCHAR2(100) NOT NULL,
    nr_telefone NUMBER NOT NULL,
    nm_login    VARCHAR2(50) NOT NULL,
    ds_senha    VARCHAR2(16) NOT NULL
);

ALTER TABLE t_mc_cliente ADD ( cd_cliente NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

ALTER TABLE t_mc_cliente
    ADD CONSTRAINT poder_ser_lov CHECK ( tp_pessoa IN ( 'F', 'J' ) );

COMMENT ON COLUMN t_mc_cliente.cd_cliente IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_cliente.tp_pessoa IS
    'Capitular tipo de pessoa (valor discriminador para entidades específicas atreladas): Pessoa "F"ísica ou Pessoa "J"urídica.';

COMMENT ON COLUMN t_mc_cliente.nm_cliente IS
    'Capitular nome completo do cliente. Não pode sofrer restrição única por causa dos casos homônimos.';

COMMENT ON COLUMN t_mc_cliente.qt_estrelas IS
    'quantidade de estrelas do cliente: valor atribuído por cálculo ainda a ser decidido pelo administração do projeto.';

COMMENT ON COLUMN t_mc_cliente.st_cliente IS
    'Capitular status do cliente: "A"tivo, "I"nativo';

COMMENT ON COLUMN t_mc_cliente.ds_email IS
    'ds email: formato obrigatório <nome@provedor>';

COMMENT ON COLUMN t_mc_cliente.nr_telefone IS
    '+ DDI + DD + <número variável>
número de telefone. único. caso haja necessidade do negócio de ter mais de um, criar nova tabela para telefones de clientes.';

COMMENT ON COLUMN t_mc_cliente.nm_login IS
    'nm_login: login cadastrado pelo usuário';

COMMENT ON COLUMN t_mc_cliente.ds_senha IS
    'formato, restrições e obrigações de caracteres  a serem definidos pela administração do projeto.';

ALTER TABLE t_mc_cliente
    ADD CONSTRAINT ck_mc_cliente_status CHECK ( st_cliente IN ( 'A', 'I' ) );

ALTER TABLE t_mc_cliente
    ADD CONSTRAINT ck_mc_cliente_tipo CHECK ( st_cliente IN ( 'F', 'J' ) );

ALTER TABLE t_mc_cliente ADD CONSTRAINT un_mc_cliente_login UNIQUE ( nm_login );

CREATE TABLE t_mc_codigo_postal (
    cd_cep        NUMBER(8) NOT NULL,
    ds_logradouro VARCHAR2(100) NOT NULL,
    ds_bairro     VARCHAR2(50) NOT NULL,
    ds_municipio  VARCHAR2(50) NOT NULL,
    sg_estado     CHAR(2) NOT NULL
);

COMMENT ON COLUMN t_mc_codigo_postal.cd_cep IS
    'cep: única chave primária do projeto não gerada por identity. tabela de cep, Capitular: logradouro, bairro, município, estado fornecida pelos correios.'
    ;

COMMENT ON COLUMN t_mc_codigo_postal.ds_logradouro IS
    'Capitular.';

COMMENT ON COLUMN t_mc_codigo_postal.ds_bairro IS
    'Capitular.';

COMMENT ON COLUMN t_mc_codigo_postal.ds_municipio IS
    'Capitular.';

COMMENT ON COLUMN t_mc_codigo_postal.sg_estado IS
    'Caixa Alta:: 26 Estados + DF';

ALTER TABLE t_mc_codigo_postal ADD CONSTRAINT pk_mc_codigo_postal PRIMARY KEY ( cd_cep );

CREATE TABLE t_mc_departamento (
    nm_dpto  VARCHAR2(50) NOT NULL,
    sg_dpto CHAR(3) NOT NULL
);

ALTER TABLE t_mc_departamento ADD ( cd_dpto NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_departamento.cd_dpto IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_departamento.nm_dpto IS
    'Capitular nm departamento nome simples';

COMMENT ON COLUMN t_mc_departamento.sg_dpto IS
    'Caixa Alta:: somente 3 letras.';

CREATE TABLE t_mc_endereco_cliente (
    cd_cliente         INTEGER NOT NULL,
    cd_cep             NUMBER(8) NOT NULL,
    nr_numero_endereco NUMBER(6) NOT NULL,
    cp_complemento     VARCHAR2(20),
    ds_referencia      VARCHAR2(20)
);

COMMENT ON COLUMN t_mc_endereco_cliente.nr_numero_endereco IS
    'número do logradouro.';

COMMENT ON COLUMN t_mc_endereco_cliente.cp_complemento IS
    'campo alfanumérico.';

COMMENT ON COLUMN t_mc_endereco_cliente.ds_referencia IS
    'Capitular descrição de referência para facilitar entrega.';

ALTER TABLE t_mc_endereco_cliente ADD CONSTRAINT pk_mc_endereco_cliente PRIMARY KEY ( cd_cliente,
                                                                                      cd_cep );

CREATE TABLE t_mc_endereco_funcionario (
    cd_funcionario     INTEGER NOT NULL,
    cd_cep             NUMBER(8) NOT NULL,
    nr_numero_endereco NUMBER(6) NOT NULL,
    cp_complemento     VARCHAR2(20)
);

COMMENT ON COLUMN t_mc_endereco_funcionario.nr_numero_endereco IS
    'número do logradouro.';

COMMENT ON COLUMN t_mc_endereco_funcionario.cp_complemento IS
    'campo alfanumérico';

ALTER TABLE t_mc_endereco_funcionario ADD CONSTRAINT pk_mc_endereco_funcionario PRIMARY KEY ( cd_funcionario,
                                                                                              cd_cep );

CREATE TABLE t_mc_funcionario (
    chefia_cd_funcionario INTEGER NOT NULL,
    cd_depto              INTEGER NOT NULL,
    nm_funcionario        VARCHAR2(50) NOT NULL,
    nr_cpf                NUMBER(11) NOT NULL,
    dt_nascimento         DATE NOT NULL,
    ds_genero             CHAR(1) NOT NULL,
    ds_cargo              VARCHAR2(20) NOT NULL,
    vl_salario_mennsal    NUMBER(8, 2) NOT NULL,
    ds_email              VARCHAR2(100) NOT NULL,
    dt_admissao           DATE NOT NULL,
    dt_desligamento       DATE
);

ALTER TABLE t_mc_funcionario ADD ( cd_funcionario NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_funcionario.cd_funcionario IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_funcionario.chefia_cd_funcionario IS
    'chefia: código do chefe do funcionário';

COMMENT ON COLUMN t_mc_funcionario.nm_funcionario IS
    'Capitular: nome completo do funcionário';

COMMENT ON COLUMN t_mc_funcionario.nr_cpf IS
    'nr_cnpj: restrição única. é desejável que haja checagem com banco de dados da receita federal.';

COMMENT ON COLUMN t_mc_funcionario.dt_nascimento IS
    'DD/MM/AAAA';

COMMENT ON COLUMN t_mc_funcionario.ds_genero IS
    'Capitular ds_gênero: gênero autodeclarado do cliente como "M"asculino, "F"eminino ou "O"utro. Exclusão dos campos sugeridos de "Gênero de Nascimento" e "Sexo biológico". Não há necessidade de exigir que o cliente revele seu sexo biológico (irrelevante para o negócio). Para maiores informações sobre boas práticas em comunicação com gêneros e identidades, acesse <https://www.grupodignidade.org.br/wp-content/uploads/2018/05/manual-comunicacao-LGBTI.pdf>.'
    ;

COMMENT ON COLUMN t_mc_funcionario.ds_cargo IS
    'Capitular descrição simples do cargo';

COMMENT ON COLUMN t_mc_funcionario.vl_salario_mennsal IS
    'Em reais.
>=1412';

COMMENT ON COLUMN t_mc_funcionario.ds_email IS
    'padrão <nome@provedor>';

COMMENT ON COLUMN t_mc_funcionario.dt_admissao IS
    'DD/MM/AAAA';

COMMENT ON COLUMN t_mc_funcionario.dt_desligamento IS
    'DD/MM/AAAA';

ALTER TABLE t_mc_funcionario ADD CONSTRAINT ck_mc_func_vl_salario_mensal CHECK ( vl_salario_mennsal >= 1412 );

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT ck_mc_funcionario_genero CHECK ( ds_genero IN ( 'M', 'F', 'O' ) );

ALTER TABLE t_mc_funcionario ADD CONSTRAINT un_mc_funcionario_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_mc_p_fisica (
    cd_cliente    INTEGER NOT NULL,
    nr_cpf        NUMBER(11) NOT NULL,
    dt_nascimento DATE NOT NULL,
    ds_genero     CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_mc_p_fisica.nr_cpf IS
    'nr_cpf: restrição única. é desejável que haja checagem com banco de dados da receita federal.';

COMMENT ON COLUMN t_mc_p_fisica.dt_nascimento IS
    'DD/MM/AAAA
restrição desejável: maior de 18 anos.';

COMMENT ON COLUMN t_mc_p_fisica.ds_genero IS
    'Capitular ds_gênero: gênero autodeclarado do cliente como "M"asculino, "F"eminino ou "O"utro. Exclusão dos campos sugeridos de "Gênero de Nascimento" e "Sexo biológico". Não há necessidade de exigir que o cliente revele seu sexo biológico (irrelevante para o negócio). Para maiores informações sobre boas práticas em comunicação com gêneros e identidades, acesse <https://www.grupodignidade.org.br/wp-content/uploads/2018/05/manual-comunicacao-LGBTI.pdf>.'
    ;

ALTER TABLE t_mc_p_fisica
    ADD CONSTRAINT ck_mc_p_fisica_genero CHECK ( ds_genero IN ( 'M', 'F', 'O' ) );

ALTER TABLE t_mc_p_fisica ADD CONSTRAINT pk_mc_p_fisica_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_mc_p_fisica ADD CONSTRAINT un_mc_p_fisica_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_mc_p_juridica (
    cd_cliente            INTEGER NOT NULL,
    nr_cnpj               NUMBER(14) NOT NULL,
    dt_fundacao           DATE,
    nr_inscricao_estadual NUMBER(9)
);

COMMENT ON COLUMN t_mc_p_juridica.nr_cnpj IS
    'nr_cnpj: restrição única. é desejável que haja checagem com banco de dados da receita federal.';

COMMENT ON COLUMN t_mc_p_juridica.dt_fundacao IS
    'DD/MM/AAAA';

COMMENT ON COLUMN t_mc_p_juridica.nr_inscricao_estadual IS
    'desejável verificar com a administração do projeto a obrigatoriedade ou opcionalidade do atributo.';

ALTER TABLE t_mc_p_juridica ADD CONSTRAINT pk_mc_p_juridica PRIMARY KEY ( cd_cliente );

CREATE TABLE t_mc_produto (
    cd_categoria_produto INTEGER NOT NULL,
    nm_produto           VARCHAR2(50) NOT NULL,
    ds_completa_produto  CLOB NOT NULL,
    cd_barras            NUMBER(13),
    vl_preco_unitario    NUMBER(7, 2) NOT NULL,
    st_produto           CHAR(1) NOT NULL
);

ALTER TABLE t_mc_produto ADD ( cd_produto NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_produto.cd_produto IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_produto.nm_produto IS
    'Capitular: nome simples da categoria do produto.';

COMMENT ON COLUMN t_mc_produto.ds_completa_produto IS
    'Capitular: descrição mais completa da categoria do produto.';

COMMENT ON COLUMN t_mc_produto.cd_barras IS
    'Padrão EAN13';

COMMENT ON COLUMN t_mc_produto.vl_preco_unitario IS
    'Em reais.';

COMMENT ON COLUMN t_mc_produto.st_produto IS
    'Capitular status do produto: "A"tivo, "I"nativo, Em "P"rospecção. O produto não deve ser visualizado pelos clientes quando estiver com status "I" ou "P", somente "A"'
    ;

ALTER TABLE t_mc_produto
    ADD CONSTRAINT ck_mc_produto_status CHECK ( st_produto IN ( 'A', 'I', 'P' ) );

ALTER TABLE t_mc_produto ADD CONSTRAINT un_mc_produto_nome UNIQUE ( nm_produto );

CREATE TABLE t_mc_video_produto (
    cd_produto             INTEGER NOT NULL,
    cd_classificacao_video INTEGER NOT NULL,
    st_video               CHAR(1) NOT NULL,
    dt_cadastro            DATE
);

ALTER TABLE t_mc_video_produto ADD ( cd_video NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_video_produto.cd_video IS
    'Código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_video_produto.st_video IS
    'Capitular status do vídeo: "A"tivo ou "I"nativo. CHAR1
';

COMMENT ON COLUMN t_mc_video_produto.dt_cadastro IS
    'DD/MM/AAAA data de upload do vídeo do produto.';

ALTER TABLE t_mc_video_produto
    ADD CONSTRAINT ck_mc_video_produto_status CHECK ( st_video IN ( 'A', 'I' ) );

CREATE TABLE t_mc_visualizacao_video (
    cd_cliente        INTEGER NOT NULL,
    cd_video          NUMBER(6) NOT NULL,
    dt_visualizacao   DATE NOT NULL,
    ds_usuario_logado VARCHAR2(50)
);

ALTER TABLE t_mc_visualizacao_video ADD ( cd_visualizacao NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) PRIMARY KEY);

COMMENT ON COLUMN t_mc_visualizacao_video.cd_visualizacao IS
    'código sequencial gerado identity (incremento de +1). BIGINT (padrão escolhido para os códigos do Projeto Melhores Compras).';

COMMENT ON COLUMN t_mc_visualizacao_video.cd_video IS
    'trazer código do produto';

COMMENT ON COLUMN t_mc_visualizacao_video.dt_visualizacao IS
    'DD/MM/AAAA
HH:MM:SS 
Data, hora minutos e segundos da visualização';

COMMENT ON COLUMN t_mc_visualizacao_video.ds_usuario_logado IS
    'nome do login (nm_login) do usuário, quando for assistido por um  usuário logado. 
valor NULL quando for visto por usuário anônimo.';

ALTER TABLE t_mc_chamado_sac
    ADD CONSTRAINT fk_mc_chamado_sac_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_mc_cliente ( cd_cliente );

ALTER TABLE t_mc_chamado_sac
    ADD CONSTRAINT fk_mc_chamado_sac_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_chamado_sac
    ADD CONSTRAINT fk_mc_chamado_sac_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_produto ( cd_produto );

ALTER TABLE t_mc_endereco_cliente
    ADD CONSTRAINT fk_mc_ende_cli_cep FOREIGN KEY ( cd_cep )
        REFERENCES t_mc_codigo_postal ( cd_cep );

ALTER TABLE t_mc_endereco_cliente
    ADD CONSTRAINT fk_mc_ende_cli_t_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_mc_cliente ( cd_cliente );

ALTER TABLE t_mc_endereco_funcionario
    ADD CONSTRAINT fk_mc_ende_func_cep FOREIGN KEY ( cd_cep )
        REFERENCES t_mc_codigo_postal ( cd_cep );

ALTER TABLE t_mc_endereco_funcionario
    ADD CONSTRAINT fk_mc_ende_func_t_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT fk_mc_func_depto FOREIGN KEY ( cd_depto )
        REFERENCES t_mc_departamento ( cd_dpto );

ALTER TABLE t_mc_funcionario
    ADD CONSTRAINT fk_mc_func_t_func FOREIGN KEY ( chefia_cd_funcionario )
        REFERENCES t_mc_funcionario ( cd_funcionario );

ALTER TABLE t_mc_p_fisica
    ADD CONSTRAINT fk_mc_p_fisica_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_mc_cliente ( cd_cliente );

ALTER TABLE t_mc_p_juridica
    ADD CONSTRAINT fk_mc_p_juridica_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_mc_cliente ( cd_cliente );

ALTER TABLE t_mc_produto
    ADD CONSTRAINT fk_mc_prod_cat_prod FOREIGN KEY ( cd_categoria_produto )
        REFERENCES t_mc_categoria_produto ( cd_categoria_produto );

ALTER TABLE t_mc_video_produto
    ADD CONSTRAINT fk_mc_vid_prod_t_class_vid FOREIGN KEY ( cd_classificacao_video )
        REFERENCES t_mc_classificacao_video ( cd_classificacao_video );

ALTER TABLE t_mc_video_produto
    ADD CONSTRAINT fk_mc_video_prod_t_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_mc_produto ( cd_produto );

ALTER TABLE t_mc_visualizacao_video
    ADD CONSTRAINT fk_mc_visu_vid_cli FOREIGN KEY ( cd_cliente )
        REFERENCES t_mc_cliente ( cd_cliente );

ALTER TABLE t_mc_visualizacao_video
    ADD CONSTRAINT fk_mc_visu_vid_t_vid_prod FOREIGN KEY ( cd_video )
        REFERENCES t_mc_video_produto ( cd_video );

CREATE OR REPLACE TRIGGER arc_poder_ser_t_mc_p_fisica BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_mc_p_fisica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_mc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223, 'FK FK_MC_P_FISICA_CLI in Table T_MC_P_FISICA violates Arc constraint on Table T_MC_CLIENTE - discriminator column tp_pessoa doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_poder_ser_t_mc_p_juridica BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_mc_p_juridica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_pessoa
    INTO d
    FROM
        t_mc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'J' ) THEN
        raise_application_error(-20223, 'FK FK_MC_P_JURIDICA_CLI in Table T_MC_P_JURIDICA violates Arc constraint on Table T_MC_CLIENTE - discriminator column tp_pessoa doesn''t have value ''J'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             47
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
