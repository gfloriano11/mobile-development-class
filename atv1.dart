// N1-E1 - GameStore Dart
// Complete os trechos marcados com TODO.
// O programa deve funcionar no DartPad sem entrada pelo terminal.
 
// String dinheiro(double valor) => 'R$\ ${valor.toStringAsFixed(2)}';
 
class Jogo {
  final String titulo;
  final String plataforma;
  final double preco;
 
  // Construtor principal.

  const Jogo({
    required this.titulo,
    required this.plataforma,
    required this.preco,
  });
 
  // Construtor nomeado para criar um jogo com preço promocional.

  Jogo.promocional({

    required String titulo,
    required String plataforma,
    required double precoOriginal,
    required double percentualDesconto,

  })  : assert(precoOriginal >= 0, 'O preço original não pode ser negativo.'),

        assert(
          percentualDesconto >= 0 && percentualDesconto <= 100,
          'O desconto deve estar entre 0 e 100.',
        ),

        titulo = titulo,
        plataforma = plataforma,

        // TODO 1: (FEITO)
        // Calcular o preço final aplicando o percentual de desconto.

        preco = precoOriginal * (percentualDesconto~/100);

}
 
class ItemCarrinho {
  final Jogo jogo;
  final int quantidade;
  final double descontoExtra;
 
  const ItemCarrinho({

    required this.jogo,
    required this.quantidade,
    this.descontoExtra = 0,

  })  : assert(quantidade > 0, 'A quantidade deve ser maior que zero.'),

        assert(
          descontoExtra >= 0 && descontoExtra <= 50,
          'O desconto extra deve estar entre 0 e 50.',
        );
 
  // TODO 2 (FEITO):
  // Retornar preço do jogo × quantidade, aplicando o desconto extra.
  double get subtotal => (jogo.preco * (descontoExtra/100))*quantidade;

}
 
class Pedido {
  final String cliente;
  final List<ItemCarrinho> itens;
  final String? cupom;
 
  const Pedido({
    required this.cliente,
    required this.itens,
    this.cupom,

  });
 
  // TODO 3 (FEITO):
  // Somar o subtotal de todos os itens.

  double get subtotalDosItens {
    double preco = 0.0;
    
    for (var i in itens) {
      preco+=i.jogo.preco;
    }

    return preco;
  }
 
  // TODO 4 (FEITO):
  // Retornar 10% do subtotal quando o cupom for ALUNO10.
  // A comparação deve ignorar letras maiúsculas e minúsculas.

  double get valorDoDesconto {
    final cupom = this.cupom;
    if (cupom != null && cupom.toLowerCase() == "aluno10") {
      return subtotalDosItens*0.10;
    }
    return 0.0;
  }
 
  // TODO 5 (FEITO):
  // Frete grátis para subtotal igual ou maior que R$ 250,00.
  // Caso contrário, o frete custa R$ 20,00.

  double get valorDoFrete => (subtotalDosItens >= 250.00 ? 0.0 : 20.0);
 
  // TODO 6 (FEITO):
  // subtotalDosItens - valorDoDesconto + valorDoFrete

  double get totalFinal => (subtotalDosItens-valorDoDesconto+valorDoFrete);
 
  // TODO 7 (FEITO):
  // Menor que 150: Pedido econômico
  // De 150 até 300: Pedido padrão
  // Maior que 300: Pedido premium

  String get classificacao {
    if (totalFinal < 150.00) return "Pedido econônico";
    if (totalFinal >= 150.00 && totalFinal <= 300.00) return "Pedido padrão";
    return "Pedido premium";
  }
 
  // TODO 8 (FEITO):
  // Somar as quantidades de todos os itens.

  int get quantidadeTotalDeUnidades {
    final listaQuantidade = this.itens.map((i) => i.quantidade);
    return listaQuantidade.reduce(
      (value, currentValue) => value + currentValue
    );
  }

}
 
void imprimirRecibo(Pedido pedido) {
// Estrutura de impressão de recibo
  
  print("=================================\n");
  print("          GAMESTORE DART         \n");
  print("=================================\n");

  print('Cliente: ${pedido.cliente} \n');
  print('Cupom: ${pedido.cupom} \n');
  
  for (var (index, item) in pedido.itens.indexed) {
    print('${index}. ${item.jogo.titulo} \n');
    print('Plataforma: ${item.jogo.plataforma} \n');
    print('Preço unitário: RS ${item.jogo.preco} \n');
    print('Quantidade: ${item.quantidade} \n');
    print('Desconto extra: ${item.descontoExtra} \n');
    print('Subtotal: ${item.subtotal} \n');
    print('----------------------------------');
  }
}
 
void main() {
  final jogo1 = Jogo(
    titulo: 'Galaxy Battle',
    plataforma: 'PC',
    preco: 99.90,
  );
 
  final jogo2 = Jogo(
    titulo: 'Kart Turbo',
    plataforma: 'Nintendo Switch',
    preco: 189.90,
  );
 
  final jogo3 = Jogo.promocional(
    titulo: 'Dungeon Quest',
    plataforma: 'PlayStation 5',
    precoOriginal: 200.00,
    percentualDesconto: 20,
  );
 
  final jogo4 = Jogo(
    titulo: 'Pixel Farm',
    plataforma: 'PC',
    preco: 39.90,
  );
 
  // Catálogo com quatro jogos.

  final catalogo = <Jogo>[jogo1, jogo2, jogo3, jogo4];
  print('Catálogo carregado: ${catalogo.length} jogos');
  print('');
 
  final itens = <ItemCarrinho>[

    ItemCarrinho(
      jogo: jogo1,
      quantidade: 1,
    ),

    ItemCarrinho(
      jogo: jogo2,
      quantidade: 1,
      descontoExtra: 10,
    ),

    ItemCarrinho(
      jogo: jogo4,
      quantidade: 2,
    ),
  ];
 
  final pedido = Pedido(
    cliente: 'Ana',
    itens: itens,
    cupom: 'ALUNO10',
  );
 
  imprimirRecibo(pedido);
}