import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // <-- 1. Import the new package

// --- 1. DATA MODEL FOR APTIV DECKS ---
class FlashcardDeck1 {
  final String title;
  final List<String> cardImageUrls;
  List<int> cardBioRate;

  FlashcardDeck1({required this.title, required this.cardImageUrls})
    : cardBioRate = List<int>.filled(cardImageUrls.length, 0);
}

// --- 2. THE MAIN WIDGET (Handles Vertical Deck Swiping) ---
class AptivReviewPage1 extends StatefulWidget {
  final String data;
  const AptivReviewPage1({super.key, required this.data});

  @override
  State<AptivReviewPage1> createState() => _AptivReviewPageState();
}

class _AptivReviewPageState extends State<AptivReviewPage1> {
  /* ⚡ CRITICAL FIX: ALL Google Drive links are wrapped in an image proxy ⚡
   * This is the most stable form for hotlinking external resources.
   */

  final List<FlashcardDeck1> _decksbio = [
    FlashcardDeck1(
      title: 'Biology Basics (Set 1)',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/258440aa70aef8fd1404b1a27fd573a8.jpg?alt=media&token=07c4e015-45a6-49d1-84f8-1d44d1032d73',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/e9266be6ee7f7cde1b56487322b92956.jpg?alt=media&token=d1e34917-16fb-4b32-a959-50ed663c032e',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/4aa2232b7ca229095bb205c3a3b4cc49.jpg?alt=media&token=e776c14c-075c-4dd4-b1ea-94f649ba4a53',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/600b7a7c9e851ec868a64af3168c2d2d.jpg?alt=media&token=99e5531d-6ad6-4286-9c12-9bf51bd9783c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/fd1d57a26315d9fd569c035314427bed.jpg?alt=media&token=dd828bcb-e77d-4048-9d43-6e72d410789f',
      ],
    ),
    FlashcardDeck1(
      title: 'Classical Mechanics',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/2bfc31c606a9b9bcef04b56f9a513c90.jpg?alt=media&token=f8f5bb41-8e3a-47d5-8182-068aa3097bd3',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/66469c98703bc028e8bae5e3f10ff8e5.jpg?alt=media&token=745e9eaf-2a04-4153-8989-9324d26b6559',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/a8e334a44ddff92733e7cc37912affea.jpg?alt=media&token=bfbd9a6d-3670-46b4-bfdf-c04a9e13c05c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/255be928ca6108cea31963f4b4b71920.jpg?alt=media&token=ea1a6d01-91ab-4ec7-8da2-c700e34c52f8',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/b2713d42cb1e04a3ecbb52fc9b4413f7.jpg?alt=media&token=f06efa2c-79b6-4f85-8b5a-a7b9e8c45049',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/f0b9135ff6108d916de0f771f30298f8.jpg?alt=media&token=1522592a-bbcc-44f9-af7d-985c0a3e736b',
      ],
    ),
    FlashcardDeck1(
      title: 'Ee sala cup namdu',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/e83001d7a214a0037c115c5fa9961ad2.jpg?alt=media&token=deeac9d1-0078-4a94-87b3-065ddb41ac28',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/6be35fe0c4b91d1033ad7ba5d4590cd3.jpg?alt=media&token=b2e4ec48-2265-49ae-9396-4717fcc2929a',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/ee0708c8ea673eb00a75410fa1aaf14c.jpg?alt=media&token=47b8bc37-4836-4b59-8e9d-4b0bedc6e79f',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/47b90dc05dba2a49cad9220c921d7e41.jpg?alt=media&token=add8d806-e307-42b8-8a76-e1d5a26a6516',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/6f44911fe19a887afe2f63f82a457b71.jpg?alt=media&token=47ba8d6c-ab2f-4f88-9651-4a45514f6089',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/7eb4124f81ea86421b753b1b834e6501.jpg?alt=media&token=1a2aa901-c3d6-4979-a291-31666bbd9514',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/77e695f1b6ff53ed20a8ed36888c4862.jpg?alt=media&token=9d2603fd-9dc7-438b-964e-727ad8fb411c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/231a0bb140d1553662c36082715d9ee4.jpg?alt=media&token=5fdb1622-76f2-479a-adf9-3662f3a72140',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/fcda4179fae42aadea89322d08d70901.jpg?alt=media&token=fa526e3f-532b-437d-9092-24f1269502db',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/5496c328d02c848b352190a0eee94dc1.jpg?alt=media&token=49e1b195-0bbf-4326-aa01-3afbfc369e01',
      ],
    ),
    FlashcardDeck1(
      title: 'Human Systems',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/51e3ab8d1c073c03aa12d576e719fcaa.jpg?alt=media&token=ab3eac68-5513-4e79-a92a-f3171089eec3',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/6349a13fc5a712adaeb06e8c5d8d65f4.jpg?alt=media&token=fd6ddc22-12c5-4976-8b5f-4d419cefc5e7',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/e1182a1bc3d75128a9f4fe3edf6c70c3.jpg?alt=media&token=c99bf0b8-3ffa-49da-8588-ae0f06b777ed', // newrons
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/74076f45a925a78beb9e6c5abdbf069f.jpg?alt=media&token=b732fc41-ba44-45bb-8881-5841e30575a7',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/48c97020157f80c41787794670228a0a.jpg?alt=media&token=c23d1003-e695-4f6e-9b29-47769a35c88c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/350140445220e9df0cfd36ab8e8f959e.jpg?alt=media&token=18d8ac66-632d-46ff-8d8b-98a5a426ea30',
      ],
    ),

    FlashcardDeck1(
      title: 'Physical Chemistry Concepts',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/02e074cf67d22c630211fee0631d64a5.jpg?alt=media&token=f556f01d-a027-4195-9c72-9aa38dccf168',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/bf06d87d11d1dbd1be2d595facb5929e.jpg?alt=media&token=4fbd6f5d-3436-4fd9-a1ea-9d102e79dfb1',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/0d1de68f3155f529ccaafed070301ea8.jpg?alt=media&token=ecc6f9e0-5bae-4bc2-b5f0-841e76b1fcae',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/0bf17004eec5654f9ec8ea13a81d473f.jpg?alt=media&token=1cc1ad70-d0b4-4255-91db-cde83d4ed609',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/a3b550165876fb9b62c83d2ad9f38ff1.jpg?alt=media&token=b6210473-66c2-4a33-879c-e16907862a32',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/06746acae9e675a993922d4240e24437.jpg?alt=media&token=172e470b-a2ab-4992-9991-09b73694710e',
      ],
    ),
    FlashcardDeck1(
      title: 'Chemical Bonding',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/1e729584432edbb7c76a8fd7d660977f.jpg?alt=media&token=5ff06d96-1a81-4c4d-902e-6f9f0888e1ef',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/92b6251c527cb40044cbe39cd13087c1.jpg?alt=media&token=f3de8461-2af9-40e5-abd3-604df063c6e3',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/8cfcd9ddf6d3bb28bb49603db073d50e.jpg?alt=media&token=a869cf60-b2af-443a-a255-27f3cd76ad44', //covelnt
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/a33a054f01bad40db7707468596ddda6.jpg?alt=media&token=2bc5ea9f-7f5c-4089-95e1-de33aa980912',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/310b1750d2fc6e64ada675227b4dcd4d.jpg?alt=media&token=74fe3c2f-4723-4114-954c-496bed373907',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/6889c1ec362311eb79f05b432c407623.jpg?alt=media&token=9063401e-e5c3-4392-bfc1-4b1bd785c4a8',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/cc0d727fd4757b70b8bea566ed72a2c2.jpg?alt=media&token=8039d1d5-a127-4c24-b543-bbf44d94fc3d',
      ],
    ),

    FlashcardDeck1(
      title: 'Chemical Thermodynamics',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/db85b93c3b14fb5fdd6618a266013159.jpg?alt=media&token=34b84aac-cd28-44eb-8675-3ae6d27fd322',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/8dca8319fadb07aa82bf00a94f4fcc04.jpg?alt=media&token=03b12517-d4ac-43be-ad99-b86e21e8d49e',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/312b003702e6db3f10e5f227630e8d6e.jpg?alt=media&token=3a66a248-f61d-46e8-afc0-582d81b2a962',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/614d85d0b58070d65496ffa44d5f0731.jpg?alt=media&token=cf6b4962-70c9-4704-8b22-0ac332f52a40',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/30c0ef46ec12423bda0e634c4d80e2ed.jpg?alt=media&token=97554136-ead2-4505-991f-21c81295fb10',
      ],
    ),

    FlashcardDeck1(
      title: 'Electrostats',
      cardImageUrls: const [
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/2537f56cf01f4b3fbb9513d08ac492e4.jpg?alt=media&token=9e960e10-90b0-4733-8158-d8ecbe22aa3d',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/32202b3ce70e9b51c17e5d39e59c524d.jpg?alt=media&token=ed6b3b59-2e26-4cad-bd9a-6ec48d6b7f6c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/619e0590daa63ba9c63fcc39de166273.jpg?alt=media&token=769855c5-1de5-4bd2-a328-3939aa5df243',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/8d452379e5a90431422710126d5ec17c.jpg?alt=media&token=e3a9972c-89c0-4038-b54a-1f8e2aeb2359',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/436e9d4f332bb3903e00209b55ffb784.jpg?alt=media&token=c47481b7-da7b-4655-9508-de7dea89335c',
        'https://firebasestorage.googleapis.com/v0/b/aptive-2476a.firebasestorage.app/o/487761bd6a1fe5dd2dd664bf310f9f0c.jpg?alt=media&token=2fe69d4b-cd2e-4ef1-8354-0cd5f0ded60a',
      ],
    ),
  ];

  final List<FlashcardDeck1> _deckschem = [
    FlashcardDeck1(
      title: 'Physical Chemistry Concepts',
      cardImageUrls: const [
        'https://i.pinimg.com/1200x/02/e0/74/02e074cf67d22c630211fee0631d64a5.jpg',
        'https://i.pinimg.com/736x/bf/06/d8/bf06d87d11d1dbd1be2d595facb5929e.jpg',
        'https://i.pinimg.com/736x/0d/1d/e6/0d1de68f3155f529ccaafed070301ea8.jpg',
        'https://i.pinimg.com/736x/0b/f1/70/0bf17004eec5654f9ec8ea13a81d473f.jpg',
        'https://i.pinimg.com/736x/a3/b5/50/a3b550165876fb9b62c83d2ad9f38ff1.jpg',
        'https://i.pinimg.com/736x/30/c0/ef/30c0ef46ec12423bda0e634c4d80e2ed.jpg',
      ],
    ),
    FlashcardDeck1(
      title: 'Chemical Bonding',
      cardImageUrls: const [
        'https://i.pinimg.com/736x/8c/fc/d9/8cfcd9ddf6d3bb28bb49603db073d50e.jpg',
        'https://i.pinimg.com/736x/a3/3a/05/a33a054f01bad40db7707468596ddda6.jpg',
        'https://i.pinimg.com/736x/92/b6/25/92b6251c527cb40044cbe39cd13087c1.jpg',
        'https://i.pinimg.com/736x/1e/72/95/1e729584432edbb7c76a8fd7d660977f.jpg',
        'https://i.pinimg.com/736x/31/0b/17/310b1750d2fc6e64ada675227b4dcd4d.jpg',
        'https://i.pinimg.com/736x/68/89/c1/6889c1ec362311eb79f05b432c407623.jpg',
        'https://i.pinimg.com/736x/cc/0d/72/cc0d727fd4757b70b8bea566ed72a2c2.jpg',
      ],
    ),
    FlashcardDeck1(
      title: 'Chemical Thermodynamics',
      cardImageUrls: const [
        'https://i.pinimg.com/736x/db/85/b9/db85b93c3b14fb5fdd6618a266013159.jpg',
        'https://i.pinimg.com/736x/31/2b/00/312b003702e6db3f10e5f227630e8d6e.jpg',
        'https://i.pinimg.com/736x/8d/ca/83/8dca8319fadb07aa82bf00a94f4fcc04.jpg',
        'https://i.pinimg.com/736x/61/4d/85/614d85d0b58070d65496ffa44d5f0731.jpg',
        'https://i.pinimg.com/736x/06/74/6a/06746acae9e675a993922d4240e24437.jpg',
      ],
    ),
  ];

  final List<FlashcardDeck1> _decksphy = [
    FlashcardDeck1(
      title: 'Classical Mechanics',
      cardImageUrls: const [
        'https://i.pinimg.com/736x/2b/fc/31/2bfc31c606a9b9bcef04b56f9a513c90.jpg',
        'https://i.pinimg.com/1200x/25/5b/e9/255be928ca6108cea31963f4b4b71920.jpg',
        'https://i.pinimg.com/1200x/a8/e3/34/a8e334a44ddff92733e7cc37912affea.jpg',
        'https://i.pinimg.com/1200x/66/46/9c/66469c98703bc028e8bae5e3f10ff8e5.jpg',
        'https://i.pinimg.com/1200x/b2/71/3d/b2713d42cb1e04a3ecbb52fc9b4413f7.jpg',
        'https://i.pinimg.com/1200x/f0/b9/13/f0b9135ff6108d916de0f771f30298f8.jpg',
      ],
    ),
    FlashcardDeck1(
      title: 'Thermodynamics',
      cardImageUrls: const [
        'https://i.pinimg.com/736x/25/37/f5/2537f56cf01f4b3fbb9513d08ac492e4.jpg',
        'https://i.pinimg.com/1200x/32/20/2b/32202b3ce70e9b51c17e5d39e59c524d.jpg',
        'https://i.pinimg.com/736x/61/9e/05/619e0590daa63ba9c63fcc39de166273.jpg',
        'https://i.pinimg.com/1200x/43/6e/9d/436e9d4f332bb3903e00209b55ffb784.jpg',
        'https://i.pinimg.com/736x/8d/45/23/8d452379e5a90431422710126d5ec17c.jpg',
        'https://i.pinimg.com/1200x/48/77/61/487761bd6a1fe5dd2dd664bf310f9f0c.jpg',
      ],
    ),
  ];

  final List<FlashcardDeck1> _deckshis = [
    FlashcardDeck1(
      title: 'Ee sala cup namdu',
      cardImageUrls: const [
        'https://i.pinimg.com/736x/ee/07/08/ee0708c8ea673eb00a75410fa1aaf14c.jpg',
        'https://i.pinimg.com/736x/6b/e3/5f/6be35fe0c4b91d1033ad7ba5d4590cd3.jpg',
        'https://i.pinimg.com/736x/e8/30/01/e83001d7a214a0037c115c5fa9961ad2.jpg',
        'https://i.pinimg.com/736x/47/b9/0d/47b90dc05dba2a49cad9220c921d7e41.jpg',
        'https://i.pinimg.com/736x/23/1a/0b/231a0bb140d1553662c36082715d9ee4.jpg',
        'https://i.pinimg.com/736x/77/e6/95/77e695f1b6ff53ed20a8ed36888c4862.jpg',
        'https://i.pinimg.com/736x/6f/44/91/6f44911fe19a887afe2f63f82a457b71.jpg',
        'https://i.pinimg.com/736x/7e/b4/12/7eb4124f81ea86421b753b1b834e6501.jpg',
        'https://i.pinimg.com/736x/fc/da/41/fcda4179fae42aadea89322d08d70901.jpg',
        'https://i.pinimg.com/736x/54/96/c3/5496c328d02c848b352190a0eee94dc1.jpg',
      ],
    ),
  ];

  late List<FlashcardDeck1> _decks;

  @override
  void initState() {
    super.initState();

    String input = widget.data.toLowerCase();

    if (input.contains('biology')) {
      _decks = _decksbio;
    } else if (input.contains('chemistry')) {
      _decks = _deckschem;
    } else if (input.contains('physics')) {
      _decks = _decksphy;
    } else if (input.contains('rcb')) {
      _decks = _deckshis;
    } else {
      _decks = _decksbio;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
        backgroundColor: const Color(0xFF1D2635), // Aptiv Dark
        elevation: 0,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _decks.length,
        itemBuilder: (context, index) {
          final deck = _decks[index];
          return _DeckPageView(deck: deck, deckIndex: index);
        },
      ),
    );
  }
}

// --- 3. WIDGET FOR A SINGLE DECK VIEW (Page in the vertical scroll) ---
class _DeckPageView extends StatelessWidget {
  final FlashcardDeck1 deck;
  final int deckIndex;

  const _DeckPageView({required this.deck, required this.deckIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2A2E39), // Aptiv Background
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            deck.title, // <--- Correct content placement
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xFF20C5B0), // Aptiv Accent Teal
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              '↔️ Swipe Card: Prev/Next | 👆👆 Double Tap: Mark Understood',
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(child: _FlashcardViewer(deck: deck)),

          _StatsDisplay(deck: deck, deckIndex: deckIndex),
        ],
      ),
    );
  }
}

// --- 4. WIDGET TO DISPLAY STATS (Footer) ---
class _StatsDisplay extends StatelessWidget {
  final FlashcardDeck1 deck;
  final int deckIndex;

  const _StatsDisplay({required this.deck, required this.deckIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
    );
  }
}

// Global colors for stat distinction
const List<Color> statColors = [
  Colors.blueAccent,
  Colors.lightGreen,
  Colors.orangeAccent,
];

// --- 5. WIDGET FOR CARD VIEWING AND SWIPE LOGIC (Horizontal Swiping) ---
class _FlashcardViewer extends StatefulWidget {
  final FlashcardDeck1 deck;

  const _FlashcardViewer({required this.deck});

  @override
  State<_FlashcardViewer> createState() => _FlashcardViewerState();
}

class _FlashcardViewerState extends State<_FlashcardViewer> {
  int _currentIndex = 0;

  void _showPreviousImage() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + widget.deck.cardImageUrls.length) %
          widget.deck.cardImageUrls.length;
    });
  }

  void _showNextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.deck.cardImageUrls.length;
    });
  }

  void _likeShowNext() {
    setState(() {
      if (_currentIndex < widget.deck.cardBioRate.length) {
        widget.deck.cardBioRate[_currentIndex] += 1;
      }
    });
    _showNextImage();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deck.cardImageUrls.isEmpty) {
      return const Center(
        child: Text("Deck is Empty", style: TextStyle(color: Colors.white54)),
      );
    }

    // 2. Get the current image URL
    final currentImageUrl = widget.deck.cardImageUrls[_currentIndex];

    return GestureDetector(
      onDoubleTap: _likeShowNext,
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _showNextImage();
        } else if (details.primaryVelocity! > 0) {
          _showPreviousImage();
        }
      },

      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.width * 0.65,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 3. Replaced Image.network with CachedNetworkImage
              InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: CachedNetworkImage(
                  key: ValueKey(currentImageUrl), // Essential for index change
                  imageUrl: currentImageUrl,
                  fit: BoxFit.contain,

                  // Shows a spinner while the image is loading
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: const Color(0xFF20C5B0),
                        ),
                      ),

                  // Shows a robust error message if the link fails
                  errorWidget: (context, url, error) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.link_off, color: Colors.redAccent, size: 60),
                        SizedBox(height: 10),
                        Text(
                          'Image Failed: Check URL/Proxy Stability.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Card Status Text
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Card ${_currentIndex + 1} / ${widget.deck.cardImageUrls.length}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
