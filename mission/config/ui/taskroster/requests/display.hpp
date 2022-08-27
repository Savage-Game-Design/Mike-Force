import RscControlsTable;
import IGUIBack;

/*
interface Task {
  id: number;
  team: 'acav' | 'hornets' | 'mikeforce' | 'spiketeam';
  title: string;
  Distance: string;
  selected: boolean;
  acknowledged: boolean;
  position: [number, number];
  requestedAt: number;
  acceptCount: number;
}
*/

#define BORDER(N,X,Y,W,H,S,IDC) \
  class N##HoverMarkerTop: IGUIBack { \
    idc = IDC; \
    x = X; \
    y = Y; \
    w = W; \
    h = S * pixelH; \
  }; \
  class N##HoverMarkerBottom: N##HoverMarkerTop { \
    idc = IDC + 1; \
    y = Y + H - S * pixelH; \
  }; \
  class N##HoverMarkerLeft: N##HoverMarkerTop { \
    idc = IDC + 2; \
    y = Y + S * pixelH; \
    w = S * pixelW; \
    h = H - 2 * S * pixelH; \
  }; \
  class N##HoverMarkerRight: N##HoverMarkerLeft { \
    idc = IDC + 3; \
    x = X + W - S * pixelW; \
  }

class Requests: vn_mf_RscControlsGroupNoScrollbarHV {
  idc = VN_TR_REQUESTS_TAB_IDC;
  x = VN_TR_SHEET_L_X;
  y = VN_TR_SHEET_L_Y;
  w = VN_TR_SHEET_L_W + VN_TR_SHEET_R_W;
  h = VN_TR_SHEET_L_H;
  show = 0;

  class Controls {
    #define LEFT_PAGE_OUTER_X UIW(0.6)
    #define LEFT_PAGE_OUTER_Y UIH(0.5)
    #define LEFT_PAGE_OUTER_W UIW(18.6)
    #define LEFT_PAGE_OUTER_H UIH(22.4)

    #define LEFT_PAGE_INNER_X UIW(1.3)
    #define LEFT_PAGE_INNER_Y UIH(1.1)
    #define LEFT_PAGE_INNER_W (LEFT_PAGE_OUTER_W - LEFT_PAGE_INNER_X - UIW(1.9))
    #define LEFT_PAGE_INNER_H (LEFT_PAGE_OUTER_H - LEFT_PAGE_INNER_Y - UIH(0.9))

    #define RIGHT_PAGE_X UIW(19.9)
    #define RIGHT_PAGE_Y UIH(0.4)
    #define RIGHT_PAGE_W UIW(18.6)
    #define RIGHT_PAGE_H UIH(22.6)

    class LeftPage: vn_mf_RscControlsGroupNoScrollbarHV {
      x = LEFT_PAGE_OUTER_X;
      y = LEFT_PAGE_OUTER_Y;
      w = LEFT_PAGE_OUTER_W;
      h = LEFT_PAGE_OUTER_H;

      class Controls {
        class Inner: vn_mf_RscText {
          x = LEFT_PAGE_INNER_X;
          y = LEFT_PAGE_INNER_Y;
          w = LEFT_PAGE_INNER_W;
          h = LEFT_PAGE_INNER_H;
        };

        class Title: vn_mf_RscText {
          text = "Support Requests /loc";
          colorText[] = { 0, 0, 0, 1 };
          x = LEFT_PAGE_INNER_X;
          y = LEFT_PAGE_INNER_Y;
          w = LEFT_PAGE_INNER_W;
          h = UIH(1);
          style = ST_CENTER;
          sizeEx = TXT_M;
        };

        class List: RscControlsTable {
          idc = VN_TR_REQUESTS_TAB_LIST_IDC;
          x = LEFT_PAGE_INNER_X;
          y = LEFT_PAGE_INNER_Y + UIH(1);
          w = LEFT_PAGE_INNER_W + UIH(0.1);
          h = LEFT_PAGE_INNER_H - UIH(1);

          firstIDC = 42000;
          lastIDC = 44999;

          #define ROW_HEIGHT UIH(2)
          rowHeight = ROW_HEIGHT;

          class RowTemplate {
            #define BLOCK_SIZE 1.3
            #define BLOCK_W UIW(BLOCK_SIZE)
            #define BLOCK_H UIH(BLOCK_SIZE)
            #define GAP UIH(0.1)

            #define BLOCK_Y ((ROW_HEIGHT - BLOCK_H) / 2)

            #define IMAGE_X UIW(0.5)
            #define IMAGE_Y BLOCK_Y
            #define IMAGE_W BLOCK_W
            #define IMAGE_H BLOCK_H

            #define TITLE_X (IMAGE_X + IMAGE_W + GAP)
            #define TITLE_Y BLOCK_Y
            #define TITLE_W UIW(7)
            #define TITLE_H BLOCK_H

            #define PLAYER_X (TITLE_X + TITLE_W + GAP)

            #define ACTION_Y BLOCK_Y
            #define ACTION_W BLOCK_W
            #define ACTION_H BLOCK_H

            #define PLAYER_W (LEFT_PAGE_INNER_W - TITLE_W - TITLE_X - GAP - ACTION_W - IMAGE_X)
            #define ACTION_X (PLAYER_X + PLAYER_W + GAP)

            #define BORDER_SIZE 2

            class Background {
              controlBaseClassPath[] = { "IGUIBack" };
              columnX = IMAGE_X;
              controlOffsetY = IMAGE_Y;
              columnW = ACTION_X + ACTION_W - IMAGE_X;
              controlH = IMAGE_H;
            };

            class HoverMarkerTop {
              controlBaseClassPath[] = { "IGUIBack" };
              columnX = IMAGE_X;
              controlOffsetY = IMAGE_Y;
              columnW = ACTION_X + ACTION_W - IMAGE_X;
              controlH = BORDER_SIZE * pixelH;
            };
            class HoverMarkerBottom: HoverMarkerTop {
              controlOffsetY = IMAGE_Y + IMAGE_H - BORDER_SIZE * pixelH;
            };
            class HoverMarkerLeft: HoverMarkerTop {
              controlOffsetY = IMAGE_Y + BORDER_SIZE * pixelH;
              columnW = BORDER_SIZE * pixelW;
              controlH = IMAGE_H - BORDER_SIZE * pixelH * 2;
            };
            class HoverMarkerRight: HoverMarkerLeft {
              columnX = ACTION_X + ACTION_W - BORDER_SIZE * pixelW;
            };

            class TeamIconPulseBg {
              controlBaseClassPath[] = { "vn_mf_RscPictureKeepAspect" };
              columnX = IMAGE_X;
              controlOffsetY = BLOCK_Y;
              columnW = IMAGE_W;
              controlH = IMAGE_H;
            };
            class TeamIconBlk: TeamIconPulseBg {};
            class TeamIconClr: TeamIconPulseBg {};
            class TeamIconFullClr: TeamIconPulseBg {};

            class Title {
              controlBaseClassPath[] = { "vn_tr_requestTitle" };
              columnX = TITLE_X;
              controlOffsetY = TITLE_Y;
              columnW = TITLE_W;
              controlH = TITLE_H;
            };
            class Distance: Title {
              controlBaseClassPath[] = { "vn_tr_requestTitle" };
              columnX = PLAYER_X;
              columnW = PLAYER_W;
            };
            class QuickAction: Title {
              controlBaseClassPath[] = { "RscButton" };
              columnX = ACTION_X;
              controlOffsetY = ACTION_Y;
              columnW = ACTION_W;
              controlH = ACTION_H;
            };

            class SelectionMarker {
              controlBaseClassPath[] = { "vn_mf_RscPicture" };
              columnX = 0;
              controlOffsetY = 0;
              columnW = LEFT_PAGE_INNER_W;
              controlH = ROW_HEIGHT;
            };
          };
        };
      };
    };

    class RightPage: vn_mf_RscControlsGroupNoScrollbarHV {
      idc = VN_TR_REQUESTS_TAB_DETAILS_IDC;
      x = RIGHT_PAGE_X;
      y = RIGHT_PAGE_Y;
      w = RIGHT_PAGE_W;
      h = RIGHT_PAGE_H;
      class Controls {
        class Map: vn_mf_RscMapControl {
          idc = VN_TR_REQUESTS_TAB_MAP_IDC;
          x = VN_TR_SHEET_L_X + RIGHT_PAGE_X + UIW(1.7);
          y = VN_TR_SHEET_L_Y + RIGHT_PAGE_Y + UIH(1.7);
          w = UIW(8);
          h = UIH(8);
        };

        class Thumbnail: vn_mf_RscPicture {
          idc = VN_TR_REQUESTS_TAB_THUMBNAIL_IDC;
          x = UIW(6);
          y = UIH(2.5);
          w = UIW(12);
          h = UIH(8);
        };
        class Frame: Thumbnail {
          idc = -1;
          text = "\vn\ui_f_vietnam\ui\debrief\pictureframe.paa";
        };

        class Description: vn_mf_RscStructuredText {
          idc = VN_TR_REQUESTS_TAB_DESCRIPTION_IDC;
          x = UIW(1.7);
          y = UIH(10.8);
          w = UIW(16.3);
          h = UIH(2);
          text = "// TODO: Description";
          colorText[] = { 0, 0, 0, 1 };
        };

        class Conditions: RscControlsTable {
          idc = VN_TR_REQUESTS_TAB_CONDITIONS_IDC;
          x = UIW(3);
          y = UIH(12.5);
          w = UIW(15);
          h = UIH(4);

          firstIDC = 42000;
          lastIDC = 44999;

          rowHeight = UIH(1);

          enable = 0;
          
          class RowTemplate {
            class CheckBox {
              controlBaseClassPath[] = { "vn_tr_checkbox" };
              columnX = 0;
              controlOffsetY = 0;
              columnW = UIW(1);
              controlH = UIH(1);
            };
            class Description {
              controlBaseClassPath[] = { "vn_tr_requestTitle" };
              columnX = UIW(1.1);
              controlOffsetY = 0;
              columnW = UIW(13);
              controlH = UIH(1);
            };
          };
        };

        class AcceptBtn: vn_mf_RscButton {
          idc = VN_TR_REQUESTS_TAB_ACCEPT_IDC;
          x = UIW(1.7);
          y = UIH(17.2);
          w = UIW(7.9);
          h = UIH(3);
          text = "Accept /loc";
          colorText[] = { 0, 0, 0, 1 };
        };

        BORDER(AcceptBtn,UIW(1.7),UIH(17.2),UIW(7.9),UIH(3),2, VN_TR_REQUESTS_TAB_ACCEPT_BT_IDC);

        class DismissBtn: AcceptBtn {
          idc = VN_TR_REQUESTS_TAB_DISMISS_IDC;
          x = UIW(10.1);
          text = "Dismiss /loc";
        };

        BORDER(DismissBtn,UIW(10.1),UIH(17.2),UIW(7.9),UIH(3),2, VN_TR_REQUESTS_TAB_DISMISS_BT_IDC);

        class Info: vn_mf_RscText {
          idc = VN_TR_REQUESTS_TAB_INFO_IDC;
          x = UIW(1.7);
          y = UIH(17.2);
          w = UIW(16.3);
          h = UIH(3);
          style = ST_CENTER;
          text = "This Request has been added to your Task Tab /loc";
          show = 0;
          colorText[] = { 0, 0, 0, 1 };
        };

        class AcceptCount: vn_mf_RscText {
          idc = VN_TR_REQUESTS_TAB_ACCEPTCOUNT_IDC;
          x = UIW(1.7);
          y = UIH(20.4);
          w = UIW(16.3);
          h = UIH(1);
          text = "// TODO: AcceptCount";
          colorText[] = { 0, 0, 0, 1 };
        };

        class RequestedAt: vn_mf_RscText {
          idc = VN_TR_REQUESTS_TAB_REQUESTEDAT_IDC;
          x = UIW(1.7);
          y = UIH(21);
          w = UIW(16.3);
          h = UIH(2);
          text = "// TODO: RequestedAt";
          style = ST_RIGHT;
          colorText[] = { 0, 0, 0, 1 };
        };
      };
    };
  };
};