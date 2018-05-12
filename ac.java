package com.example.root.qr;

import android.accessibilityservice.AccessibilityService;
import android.app.Service;
import android.content.Intent;
import android.graphics.Rect;
import android.os.IBinder;
import android.util.Log;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

public class ac extends AccessibilityService {
    private static final String PNAME = "pname";
    private static final String CLASS = "class";
    private static final String NODE = "node";
    private static final String TAG = "info";
    private static final String pname = "com.tencent.mm";
    private String mall = "com.tencent.mm.plugin.mall.ui.MallIndexUI";
    private String myWallet = "我的钱包";
    private String pay = "微信支付";
    private String cpClassName = "com.tencent.mm.plugin.offline.ui.WalletOfflineCoinPurseUI";
    private String cp = "收付款";
    private String collectClassName = "com.tencent.mm.plugin.collect.ui.CollectMainUI";
    private String collect = "二维码收款";
    private String my = "我";
    private String qrClassNme = "com.tencent.mm.plugin.collect.ui.CollectCreateQRCodeUI";
    private String settingText = "设置金额";
    private String save = "保存收款码";

    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        Log.d(TAG, "onAccessibilityEvent: " + event.toString());
        if (event.getEventType() == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED &&
                event.getPackageName().equals(pname)) {
            CharSequence className = event.getClassName();
            Log.d(PNAME, event.getPackageName().toString());
            if (className.toString().equals(collectClassName)) {
                Log.d(CLASS, className.toString());
                AccessibilityNodeInfo rootNode = event.getSource();
                List<AccessibilityNodeInfo> setting = rootNode.findAccessibilityNodeInfosByText(save);
                Log.d("节点",setting.get(0).toString());
                AccessibilityNodeInfo setNodeInfo = setting.get(0);
                Rect rect = new Rect();
                setNodeInfo.getBoundsInScreen(rect);
                //boundsInScreen: Rect(624, 1101 - 819, 1154)
                int top = rect.top;
                int bottom = rect.bottom;
                int left = rect.left;
                int right = rect.right;
                int x = (right - left) / 2 + left;
                int y = (bottom - top) / 2 + top;
                //721 1127
                Log.d("xy", x + " " + y);
                String cmd = "input tap " + x + " " + y;
                try{
                    Process sh = Runtime.getRuntime().exec(cmd);
                    DataOutputStream outputStream = new DataOutputStream(sh.getOutputStream());
                    outputStream.writeBytes("exit\n");
                    outputStream.flush();
                } catch(IOException e) {
                    e.printStackTrace();
                }
//                try {
//                        Process p = Runtime.getRuntime().exec("input tap 721 1127");
//                        OutputStream outputStream = p.getOutputStream();
//                        DataOutputStream dataOutputStream = new DataOutputStream(outputStream);
//                        dataOutputStream.writeBytes(cmd);
//                        dataOutputStream.flush();
//                        dataOutputStream.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
                Log.d("cmd", cmd);
                setNodeInfo.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                setNodeInfo.getParent().performAction(AccessibilityNodeInfo.ACTION_CLICK);
                if (rootNode != null) {
                    int count = rootNode.getChildCount();
                    for (int i = 0; i < count; i++) {
                        AccessibilityNodeInfo nodeInfo = rootNode.getChild(i);
                        Log.d(NODE, nodeInfo.toString());
                        if (nodeInfo == rootNode.findAccessibilityNodeInfosByText(settingText)) {
                            nodeInfo.performAction(AccessibilityNodeInfo.ACTION_CLICK);
                        }
                    }
                }
            }
        }
    }

    @Override
    public void onInterrupt() {
    }
}
