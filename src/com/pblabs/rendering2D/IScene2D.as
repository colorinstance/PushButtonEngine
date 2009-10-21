package com.pblabs.rendering2D
{
    import com.pblabs.rendering2D.ui.IUITarget;
    import com.pblabs.engine.core.ObjectType;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * Base interface for a 2d scene.
     */
	public interface IScene2D
	{
        /**
         * Layers are assigned positive integers between 0 and N. This tells 
         * you what N is. This can be the same as how many layers there are,
         * but you might only be using layers 2,3, and 7, in which case
         * layerCount will be 8, but there will only be three layers. 
         * 
         * <p>layerCount is mostly useful in order to iterate over all the
         * layers by calling getLayer.</p>
         * 
         * @see getLayer
         */
        function get layerCount():int;

        /**
         * Get the layer at specified index. 
         * @param index Index of layer to return.
         * @param allocateIfAbsent False by default. If true, will allocate a 
         *                         new layer if none is present.
         * @return The requested layer.
         */
        function getLayer(index:int, allocateIfAbsent:Boolean = false):DisplayObjectSceneLayer;
        
        function get sceneView():IUITarget;
        
        
        /**
         * The SceneView where the contents of this scene will be displayed. 
         */
        function set sceneView(value:IUITarget):void;
        
        /**
         * Add a DisplayObjectRenderer to the scene; all you normally have to
         * do is set scene on DisplayObjectRenderer, not call this directly.
         */
        function add(dor:DisplayObjectRenderer):void

        /**
         * Remove a DisplayObjectRenderer from the scene; all you normally have
         * to do is clear scene on DisplayObjectRenderer, or destroy its owning
         * entity, not call this directly.
         */
        function remove(dor:DisplayObjectRenderer):void;

        /**
         * Indicates that a renderer has changed, and must be redrawn. Only 
         * necessary if you are using layers that implement ICachingLayer
         * (you don't by default).
         * 
         * @param dirtyRenderer The renderer that has changed.
         */
        function invalidate(dirtyRenderer:DisplayObjectRenderer):void;
        
        /**
         * Just like invalidate, but indicates a specific region in scene 
         * coordinates. All layers will have that region redrawn.
         * @param dirty The region to redraw.
         */
        function invalidateRectangle(dirty:Rectangle):void;
        
        /**
         * Return a sorted list of the DisplayObjectRenderers under a given 
         * screen position.
         *  
         * @param screenPosition Location on screen we are curious about.
         * @param mask Only renderers with one or more of these bits set on their objectMask will be returned.
         * @return A new array containing any renderers under the point.
         * 
         */
        function getRenderersUnderPoint(screenPosition:Point, mask:ObjectType=null):Array;

        /**
         * Center the view on a position in world space.
         */
        function setWorldCenter(position:Point):void;
        
        /**
         * Pan-the view by (deltaX, deltaY) screen pixels. This takes into account zoom.
         */
        function screenPan(deltaX:int, deltaY:int):void;

        function get rotation():Number;

        /**
         * Rotation in degrees about the center point of the scene.
         */
        function set rotation(value:Number):void;
        
        function get position():Point;
        
        /**
         * The location of the view onto the scene. This is affected by sceneAlignment.  
         */
        function set position(value:Point) : void;
        
        function get zoom():Number;
        
        /**
         * Zoom/scale factor; 1 = no zoom, less than 1 = zoom out, greater than 1 = zoom in. 
         */
        function set zoom(value:Number):void;

        /**
         * The region of the scene we are currently viewing.
         */
        function get sceneViewBounds():Rectangle;
        
        function transformWorldToScene(inPos:Point):Point;
        function transformSceneToWorld(inPos:Point):Point;

        function transformSceneToScreen(inPos:Point):Point;
        function transformScreenToScene(inPos:Point):Point;
        
        function transformWorldToScreen(inPos:Point):Point;
        function transformScreenToWorld(inPos:Point):Point;
        
        function sortSpatials(array:Array):void;
	}
}