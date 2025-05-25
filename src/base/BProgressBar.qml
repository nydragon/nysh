import QtQuick.Shapes
import QtQuick
import "../provider"

BRectangle {
    id: root

    required property int radius
    readonly property int adjustedRadius: radius - strokeWidth / 2
    readonly property vector2d center: Qt.vector2d(adjustedRadius, adjustedRadius)
    readonly property real spacingAngle: (8 / (Math.max(adjustedRadius, 1) * (2 * Math.PI))) * 360

    property double progress: 0
    property int strokeWidth: 10

    width: radius * 2
    height: radius * 2

    Shape {
        anchors.fill: parent
        anchors.centerIn: parent
        anchors.margins: root.strokeWidth / 2
        preferredRendererType: Shape.CurveRenderer
        ShapePath {
            id: backingTrack
            capStyle: ShapePath.RoundCap
            fillItem: root
            strokeColor: Colors.data.colors.dark.secondary_container
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            readonly property int joinStyleIndex: 0
            readonly property variant styles: [ShapePath.BevelJoin, ShapePath.MiterJoin, ShapePath.RoundJoin]

            joinStyle: styles[joinStyleIndex]

            startX: root.adjustedRadius
            startY: 0

            PathAngleArc {
                centerX: root.center.x
                centerY: root.center.x
                radiusX: root.adjustedRadius
                radiusY: radiusX
                startAngle: -100 - root.spacingAngle * 0.5
                sweepAngle: {
                    const angle = -((360 + root.spacingAngle) * (1 - root.progress));
                    const spacing = root.strokeWidth * 5.5;

                    if (angle + spacing > 0) {
                        return 0;
                    } else if (angle > -360)
                        return angle + spacing;
                    else
                        return -360;
                }
            }
        }

        ShapePath {
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"
            startX: root.adjustedRadius
            startY: 0
            strokeColor: Colors.data.colors.dark.primary
            strokeWidth: root.strokeWidth

            PathAngleArc {
                id: m_active_arc
                centerX: root.center.x
                centerY: root.center.y
                radiusX: root.adjustedRadius
                radiusY: radiusX
                startAngle: -90 + root.spacingAngle * 0.5
                sweepAngle: {
                    const angle = (360 + root.spacingAngle) * root.progress;
                    const spacing = root.strokeWidth * 2;

                    if (angle - spacing > 0)
                        return angle - spacing;
                    else if (angle - spacing > 360)
                        return 360;
                    else
                        return 0;
                }
            }
        }
    }
}
