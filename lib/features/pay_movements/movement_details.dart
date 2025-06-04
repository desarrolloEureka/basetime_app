import 'package:basetime/features/pay_movements/movement.dart';
import 'package:basetime/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovementDetails extends ConsumerStatefulWidget {
  const MovementDetails({super.key, required this.movement});

  final Movement movement;

  static String name = 'movement-details';
  static String path = '/$name';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovementDetailsState();
}

class _MovementDetailsState extends ConsumerState<MovementDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBT(
        title: const Text('Detalle del movimiento'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.all(48),
              child: Column(
                spacing: 16,
                children: [
                  Text(
                    '¡Pago exitoso!',
                    style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Divider(color: Theme.of(context).colorScheme.surface),
                  if (widget.movement.titular != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Titular',
                          style: GoogleFonts.ubuntu(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.movement.titular!,
                          style: GoogleFonts.ubuntu(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '¿Cuánto?',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '\$${NumberFormat.currency(
                          symbol: '',
                          locale: 'es_CO',
                        ).format(widget.movement.total)}',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fecha',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${DateFormat('dd').format(widget.movement.createdAt)} de '
                        '${DateFormat('MMMM').format(widget.movement.createdAt)} de '
                        '${DateFormat('yyyy').format(widget.movement.createdAt)} \n'
                        'a las ${DateFormat('hh:mm a').format(widget.movement.createdAt)}',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Referencia',
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.movement.id,
                        style: GoogleFonts.ubuntu(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Row(
                children: List.generate(
                  14,
                  (_) => Container(
                    width: MediaQuery.of(context).size.width / 15.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: List.generate(
                  14,
                  (_) => Container(
                    width: MediaQuery.of(context).size.width / 15.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
