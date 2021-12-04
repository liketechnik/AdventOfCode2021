with import <nixpkgs> { };

let
  input = builtins.readFile ./input;
  potentiallyEmptyLines = lib.splitString "\n" input;
  lines = lib.filter (s: s != "") potentiallyEmptyLines;

  drawsRaw = builtins.elemAt lines 0;
  drawsSplit = lib.splitString "," drawsRaw;
  draws = builtins.map (s: lib.toInt s) drawsSplit;

  boardLines = lib.lists.sublist 1 (lib.lists.count (a: true) lines) lines;
  nrBoardLines = lib.lists.count (a: true) boardLines;
  boardLineNumbers = lib.lists.imap0 (i: e: {lineNumber=i / 5; content=e;}) boardLines;
  boardLinesGrouped = lib.lists.groupBy (line: builtins.toString line.lineNumber) boardLineNumbers;
  boardLinesGroupedList = lib.attrsets.attrValues boardLinesGrouped;
  boards = builtins.map(lines: 
    {
      content = lib.lists.flatten(
        builtins.map(line:
          builtins.map (s: {value=lib.toInt s; drawn=false;}) (builtins.filter (s: builtins.stringLength s > 0) (lib.splitString " " line.content))
        ) lines
      );
      number = (lib.lists.last lines).lineNumber;
    }
  ) boardLinesGroupedList;

  nextState = (boards: currentDraw:
    builtins.map(board:
      {
        number = board.number;
        content = builtins.map(number: if (number.value == currentDraw) then {value=number.value; drawn=true;} else number) board.content;
      }
    ) boards
  );
  states = lib.lists.foldl (previousStates: currentDraw: 
    previousStates ++ [{draw=currentDraw; boards=nextState (lib.lists.last previousStates).boards currentDraw;}]
  ) [{draw=null; boards=boards;}] draws;

  won = (board:
    let 
      content = lib.lists.imap1 (i: e: {index=i; e=e;}) (builtins.map(content: content.drawn) board.content);
      one5 = lib.lists.all (e: e.e) (builtins.filter (e: e.index >= 1 && e.index <= 5) content);
      six10 = lib.lists.all (e: e.e) (builtins.filter (e: e.index >= 6 && e.index <= 10) content);
      eleven15 = lib.lists.all (e: e.e) (builtins.filter (e: e.index >= 11 && e.index <= 15) content);
      sixteen20 = lib.lists.all (e: e.e) (builtins.filter (e: e.index >= 16 && e.index <= 20) content);
      twentyone25 = lib.lists.all (e: e.e) (builtins.filter (e: e.index >= 20 && e.index <= 25) content);

      one21 = lib.lists.all (e: e.e) (builtins.filter (e: e.index == 1 || e.index == 6 || e.index == 11 || e.index == 16 || e.index == 21) content);
      two22 = lib.lists.all (e: e.e) (builtins.filter (e: e.index == 2 || e.index == 7 || e.index == 12 || e.index == 17 || e.index == 22) content);
      three23 = lib.lists.all (e: e.e) (builtins.filter (e: e.index == 3 || e.index == 8 || e.index == 13 || e.index == 18 || e.index == 23) content);
      four24 = lib.lists.all (e: e.e) (builtins.filter (e: e.index == 4 || e.index == 9 || e.index == 14 || e.index == 19 || e.index == 24) content);
      five25 = lib.lists.all (e: e.e) (builtins.filter (e: e.index == 5 || e.index == 10 || e.index == 15 || e.index == 20 || e.index == 25) content);
    in
      one5 || six10 || eleven15 || sixteen20 || twentyone25 || one21 || two22 || three23 || four24 || five25
  );
  anyWon = (boards: lib.lists.any won boards);

  winningState = lib.lists.findFirst (state: anyWon state.boards) null states;
  winningBoard = lib.lists.findFirst won null winningState.boards;

  nrOfStates = lib.lists.count (a: true) states;
  statesWithNr = lib.lists.imap1 (i: state: {index=i; state=state;}) states;
  loosingStateAndBoards = lib.lists.foldl (previous: _: 
    let 

      nextWinningState = lib.lists.findFirst (state: (anyWon state.state.boards) && state.index > previous.state.index) null statesWithNr;
      nextWinningBoards = if (nextWinningState != null) then builtins.filter (board: (won board) && !(lib.lists.any (wonBoard: wonBoard.number == board.number) previous.wonBoards)) nextWinningState.state.boards else [];

    in

    {
      state = if (nextWinningState!=null) then nextWinningState else previous.state;

      wonBoards = previous.wonBoards ++ (
        if (nextWinningBoards != null && nextWinningState!= null) then 
          builtins.map (board: {number=board.number; content=board.content; draw=nextWinningState.state.draw;}) nextWinningBoards
          # [{number=nextWinningBoard.number; content=nextWinningBoard.content; draw=nextWinningState.state.draw;}] 
          else []);
    }
  ) ({state=builtins.elemAt statesWithNr 0; wonBoards=[];}) (lib.lists.range 0 nrOfStates);
  loosingState = loosingStateAndBoards.state.state;
  loosingBoard = builtins.elemAt (lib.lists.reverseList loosingStateAndBoards.wonBoards) 0;

  sum = lib.lists.foldl (sum: field: sum + (if (!field.drawn) then field.value else 0)) 0 winningBoard.content;
  sumLoosing = lib.lists.foldl (sum: field: sum + (if (!field.drawn) then field.value else 0)) 0 loosingBoard.content;
in 
  { draw = winningState.draw; sum = sum; finalScore = sum * winningState.draw; loosingSum = sumLoosing; loosingDraw = loosingBoard.draw; loosingFinalScore = sumLoosing * loosingBoard.draw; boardNumbers=builtins.map(board: board.number) boards; loosingBoard = loosingBoard;}
