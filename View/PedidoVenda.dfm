object FrmPedidoVenda: TFrmPedidoVenda
  Left = 339
  Top = 213
  Caption = 'Pedido de Venda'
  ClientHeight = 600
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  WindowState = wsMaximized
  StyleName = 'Windows'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 99
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1000
      99)
    object btnNovoPedido: TSpeedButton
      Left = 10
      Top = 7
      Width = 130
      Height = 83
      GroupIndex = 1
      Down = True
      Caption = 'Novo Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnNovoPedidoClick
    end
    object btnVerPedidos: TSpeedButton
      Left = 154
      Top = 7
      Width = 129
      Height = 84
      GroupIndex = 1
      Caption = 'Ver Pedidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = False
      OnClick = btnVerPedidosClick
    end
    object btnCancelarPedido: TSpeedButton
      Left = 298
      Top = 7
      Width = 129
      Height = 84
      Caption = 'Cancelar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnCancelarPedidoClick
    end
    object lblPedidoTitulo: TLabel
      Left = 761
      Top = 18
      Width = 153
      Height = 45
      Anchors = [akTop, akRight]
      Caption = 'Pedido N'#186':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lblNumeroPedidoValor: TLabel
      Left = 922
      Top = 18
      Width = 17
      Height = 45
      Anchors = [akTop, akRight]
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object pnlContent: TPanel
    Left = 0
    Top = 99
    Width = 1000
    Height = 501
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlBottom: TPanel
      Left = 0
      Top = 404
      Width = 1000
      Height = 97
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1000
        97)
      object lblTotal: TLabel
        Left = 19
        Top = 16
        Width = 120
        Height = 45
        Caption = 'Total: R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalValor: TLabel
        Left = 145
        Top = 16
        Width = 58
        Height = 45
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnGravarPedido: TButton
        Left = 859
        Top = 2
        Width = 130
        Height = 83
        Anchors = [akTop, akRight]
        Caption = 'Gravar Pedido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnGravarPedidoClick
      end
    end
    object pnlCliente: TPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 7
      TabOrder = 1
      DesignSize = (
        1000
        81)
      object lblCliente: TLabel
        Left = 20
        Top = 9
        Width = 51
        Height = 21
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnPesquisarCliente: TBitBtn
        Left = 86
        Top = 35
        Width = 39
        Height = 31
        Glyph.Data = {
          76060000424D7606000000000000360400002800000018000000180000000100
          08000000000040020000120B0000120B0000000100000000000000000000EDE1
          D500ECE1D800ECE1D600E9DDD000E5D7C500E5D7C400E4D7C400E5D8C200EBE2
          D700EADFD300E6D9C800E5D4BC00E1C09300E0BB8500E4CFB100E5D8C500E8D1
          B900ECE1D700E8DCCD00E2CAA900DAA45700DCA75900DFAB6100E1B06700E0AE
          6400DFAB6200E0BE8C00E0D6C200EBE0D700E8DBCB00DFB88100DAA25500E2B2
          6B00E7BC7C00E9C08600E6BA7700E5B77000E5B66F00E3B97900E5D7C300E6D7
          C400EBE0D300E6B87400EAC28C00EBC59200E7BD7E00E4C39200ECE2D800E6D8
          C600EBC59100E8BD8000E5B77100E5D2B800EBE0D400E7BC7B00E6BA7600E6C8
          9A00E6CCCC00EADED100E9BF8400E5BE8300E5BC7E00E4D6C200E0D2BC00E4CF
          B300E6B97500E7BC7D00E4C39100E1D2BC00E0D0BB00E0AC6300E5CEAA00E0D0
          B900E2C08E00E4BA7A00E4D6C300DFCEB800E4BA7900E0CFB900DECEB500E1D1
          BB00D8C4AD00FFFFFF00CDB49900CBB6A0002762B10033669900E0CFB800DECE
          B800C7BAB0005079AF00296DBD002864B3003366B300265FAD00265AA800275E
          AC00296DBE002863B0002D69B4002E5DA2002658A6002554A300265BA9002966
          AD002E51AE002657A6002466AF002457A8002556A5002764B1002458AC002655
          A5002763B000265DAC00265BA7002556A400275CA9002555A4002657A5002658
          A700265AA700275DA90000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000007A6E6B7B0000000000000000000000000000
          0000000000767767787900000000000000000000000000000000000074756768
          6376000000000000000000000000000000000070716768637273000000000000
          000000000000000000006D6E676863636F000000000000000000000000000000
          006A6B676863636C000000000000000000000000000000006566676863636900
          00000000000000003A084046000000005F606162636400000000000000001029
          06063F45585950535A5B5C5D5E000000000000001C290635393D3E44484C4F52
          54555657000000000000001107282F3425252525254B0C515253000000000000
          00000010064E2525252525252525340C4F50000000000000000008064A262525
          252525252525254B4C4D00000000000000000706472525252525252525252525
          4849000000000000000006411942432525252525252525254445460000000000
          0000050E183C2D2B25252525252525253E3F40000000000000003B0D173C2D33
          25252525252525253D060800000000000000360C16372D323825252525252525
          39063A00000000000000303115212C2D32332B25252525343529000000000000
          0000012A14202B2C2D2D2D2E2525252F06100000000000000000001D1E1F2021
          222323242526272829000000000000000000000012131415161718191A1B0607
          1C000000000000000000000000090A0B0C0D0E0F060610110000000000000000
          0000000000000102030405060708000000000000000000000000}
        TabOrder = 1
        OnClick = btnPesquisarClienteClick
      end
      object edtCodigoCliente: TEdit
        Left = 20
        Top = 36
        Width = 61
        Height = 31
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnExit = edtCodigoClienteExit
      end
      object edtNomeCliente: TEdit
        Left = 139
        Top = 36
        Width = 847
        Height = 31
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Roboto'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object pnlItens: TPanel
      Left = 0
      Top = 81
      Width = 1000
      Height = 323
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 10
      TabOrder = 2
      object tcItens: TTabControl
        Left = 10
        Top = 10
        Width = 980
        Height = 303
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Tabs.Strings = (
          'Itens do pedido')
        TabIndex = 0
        TabStop = False
        object pnlItensHeader: TPanel
          Left = 4
          Top = 32
          Width = 972
          Height = 87
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            972
            87)
          object lblProduto: TLabel
            Left = 16
            Top = 5
            Width = 59
            Height = 21
            Caption = 'Produto:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblQuantidade: TLabel
            Left = 705
            Top = 5
            Width = 84
            Height = 21
            Anchors = [akTop, akRight]
            Caption = 'Quantidade:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 756
          end
          object lblValorUnitario: TLabel
            Left = 811
            Top = 5
            Width = 99
            Height = 21
            Anchors = [akTop, akRight]
            Caption = 'Valor Unit'#225'rio:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 862
          end
          object edtCodigoProduto: TEdit
            Left = 16
            Top = 32
            Width = 61
            Height = 31
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnExit = edtCodigoProdutoExit
          end
          object btnPesquisarProduto: TBitBtn
            Left = 82
            Top = 31
            Width = 39
            Height = 31
            Glyph.Data = {
              76060000424D7606000000000000360400002800000018000000180000000100
              08000000000040020000120B0000120B0000000100000000000000000000EDE1
              D500ECE1D800ECE1D600E9DDD000E5D7C500E5D7C400E4D7C400E5D8C200EBE2
              D700EADFD300E6D9C800E5D4BC00E1C09300E0BB8500E4CFB100E5D8C500E8D1
              B900ECE1D700E8DCCD00E2CAA900DAA45700DCA75900DFAB6100E1B06700E0AE
              6400DFAB6200E0BE8C00E0D6C200EBE0D700E8DBCB00DFB88100DAA25500E2B2
              6B00E7BC7C00E9C08600E6BA7700E5B77000E5B66F00E3B97900E5D7C300E6D7
              C400EBE0D300E6B87400EAC28C00EBC59200E7BD7E00E4C39200ECE2D800E6D8
              C600EBC59100E8BD8000E5B77100E5D2B800EBE0D400E7BC7B00E6BA7600E6C8
              9A00E6CCCC00EADED100E9BF8400E5BE8300E5BC7E00E4D6C200E0D2BC00E4CF
              B300E6B97500E7BC7D00E4C39100E1D2BC00E0D0BB00E0AC6300E5CEAA00E0D0
              B900E2C08E00E4BA7A00E4D6C300DFCEB800E4BA7900E0CFB900DECEB500E1D1
              BB00D8C4AD00FFFFFF00CDB49900CBB6A0002762B10033669900E0CFB800DECE
              B800C7BAB0005079AF00296DBD002864B3003366B300265FAD00265AA800275E
              AC00296DBE002863B0002D69B4002E5DA2002658A6002554A300265BA9002966
              AD002E51AE002657A6002466AF002457A8002556A5002764B1002458AC002655
              A5002763B000265DAC00265BA7002556A400275CA9002555A4002657A5002658
              A700265AA700275DA90000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000007A6E6B7B0000000000000000000000000000
              0000000000767767787900000000000000000000000000000000000074756768
              6376000000000000000000000000000000000070716768637273000000000000
              000000000000000000006D6E676863636F000000000000000000000000000000
              006A6B676863636C000000000000000000000000000000006566676863636900
              00000000000000003A084046000000005F606162636400000000000000001029
              06063F45585950535A5B5C5D5E000000000000001C290635393D3E44484C4F52
              54555657000000000000001107282F3425252525254B0C515253000000000000
              00000010064E2525252525252525340C4F50000000000000000008064A262525
              252525252525254B4C4D00000000000000000706472525252525252525252525
              4849000000000000000006411942432525252525252525254445460000000000
              0000050E183C2D2B25252525252525253E3F40000000000000003B0D173C2D33
              25252525252525253D060800000000000000360C16372D323825252525252525
              39063A00000000000000303115212C2D32332B25252525343529000000000000
              0000012A14202B2C2D2D2D2E2525252F06100000000000000000001D1E1F2021
              222323242526272829000000000000000000000012131415161718191A1B0607
              1C000000000000000000000000090A0B0C0D0E0F060610110000000000000000
              0000000000000102030405060708000000000000000000000000}
            TabOrder = 1
            OnClick = btnPesquisarProdutoClick
          end
          object edtDescricaoProduto: TEdit
            Left = 135
            Top = 32
            Width = 564
            Height = 31
            TabStop = False
            Anchors = [akLeft, akRight]
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtQuantidade: TEdit
            Left = 705
            Top = 32
            Width = 95
            Height = 31
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Roboto'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 3
          end
          object edtValorUnitario: TEdit
            Left = 806
            Top = 32
            Width = 115
            Height = 31
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Roboto'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnKeyPress = edtValorUnitarioKeyPress
          end
          object btnAdicionarEditarItem: TBitBtn
            Left = 927
            Top = 24
            Width = 42
            Height = 39
            Anchors = [akTop, akRight]
            Glyph.Data = {
              96060000424D96060000000000008A0400007C00000020000000200000000100
              0800010000000C020000120B0000120B000000010000000100000000FF0000FF
              0000FF000000000000FF424752738FC2F52851B81E151E85EB01333333136666
              662666666606999999093D0AD703285C8F320000000000000000000000000400
              000000000000000000000000000000000000EB9D2700F4952200F3962100F296
              2100F4962100F3972100F3972000F5991F00F3962200F1952300FF8E1C00F395
              2100F4962200FF922400F3962000F49B2100F4952000F3972300FF9F2000F4A9
              4A00F4A84900FAF9F800F4A84800F0992400F5B76900FAFAFA00ED922400EA95
              2B00F7CD9900F3952200F0931F00FF993300F3942400F2992600FFAA2B00F096
              1E00E88B17000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000A00011C0106011E01050403010501090103
              01250A00000008000124010601050C03011F080000000600010E011111030123
              06000000050001221303010F0110050000000400011216030121040000000300
              011018030110030000000200012001061803010F010E020000000200010D0C03
              02170D03020000000100010A0C030115021601170C03011F0100000001000D03
              0119021A01190D0301000000011C0D030119021A01190C030105011C00000107
              0D030119021A01190E03000001060D030119021A01190D03011E000001040D03
              0119021A01190E030000080301170519011D021A011D05190117080300000703
              011501160E1A01160117070300000703011501160E1A01160117070300000803
              01140519011D021A011D051901150803000001040D030119021A01190E030000
              0E030119021A01190E03000001020D030119021A01190D0301060000011B0D03
              0119021A01190C030105011C0000010001090C030119021A01190C0301060100
              00000100010801050B030115021601170C030118010000000200010C0C030114
              01150C03011102000000020001131903010C010E020000000300010A18030110
              030000000400011116030112040000000500010A01061203010F011005000000
              0600010B010C01050F03010D010E060000000800010801090D03010A08000000
              0A000101010201030104040301050106010701010A0000000001}
            TabOrder = 5
            OnClick = btnAdicionarEditarItemClick
          end
        end
        object pnlItensContent: TPanel
          Left = 4
          Top = 119
          Width = 972
          Height = 180
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object grdItensPedido: TDBGrid
            Left = 0
            Top = 0
            Width = 972
            Height = 180
            Align = alClient
            DataSource = dsItensPedido
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -16
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnKeyDown = grdItensPedidoKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'codigo'
                Title.Caption = 'C'#243'digo'
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'descricao'
                Title.Caption = 'Descri'#231#227'o'
                Width = 542
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'quantidade'
                Title.Caption = 'Quantidade'
                Width = 95
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorUnitario'
                Title.Caption = 'Valor Unit'#225'rio'
                Width = 112
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorTotal'
                Title.Caption = 'Valor Total'
                Width = 88
                Visible = True
              end>
          end
        end
      end
    end
  end
  object dsItensPedido: TDataSource
    DataSet = cdsItensPedido
    Left = 46
    Top = 433
  end
  object cdsItensPedido: TClientDataSet
    PersistDataPacket.Data = {
      AB0000009619E0BD010000001800000005000000000003000000AB0006636F64
      69676F04000100000000000964657363726963616F0200490000000100055749
      445448020002002C010A7175616E74696461646504000100000000000D76616C
      6F72556E69746172696F08000400000001000753554254595045020049000600
      4D6F6E6579000A76616C6F72546F74616C080004000000010007535542545950
      450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 300
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valorUnitario'
        DataType = ftCurrency
      end
      item
        Name = 'valorTotal'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 142
    Top = 433
    object cdsItensPedidoCodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cdsItensPedidoDescricao: TStringField
      FieldName = 'descricao'
      Size = 300
    end
    object cdsItensPedidoQuantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object cdsItensPedidoValorUnitario: TCurrencyField
      FieldName = 'valorUnitario'
    end
    object cdsItensPedidoValorTotal: TCurrencyField
      FieldName = 'valorTotal'
    end
  end
end
