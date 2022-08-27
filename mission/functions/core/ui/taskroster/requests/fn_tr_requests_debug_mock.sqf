// interface Task {
//   id: number;
//   team: 'acav' | 'hornets' | 'mikeforce' | 'spiketeam';
//   title: string;
//   Distance: string;
//   selected: boolean;
//   acknowledged: boolean;
//   position: [number, number];
//   requestedAt: number;
//   acceptCount: number;
// }

VN_TR_REQUESTS_DATA_LIST_UNSORTED = [];

private _taskA = [
  /* id */ 0,
  /* team */ "acav",
  /* config */ "support_transport",
  /* Distance */ "Heyoxe",
  /* selected */ false,
  /* acknowledged */ false,
  /* position */ [10240, 10240],
  /* requestedAt */ 0,
  /* acceptCount */ 0
];

private _taskB = [
  /* id */ 1,
  /* team */ "hornets",
  /* config */ "support_gh_cas",
  /* Distance */ "Terra",
  /* selected */ false,
  /* acknowledged */ true,
  /* position */ [8240, 15240],
  /* requestedAt */ 100,
  /* acceptCount */ 1
];

VN_TR_REQUESTS_DATA_LIST_UNSORTED = [_taskA, _taskB];